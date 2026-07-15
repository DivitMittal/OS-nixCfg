{
  pkgs,
  lib,
  ...
}: let
  # Stable ClamAV + YARA scan setup for home-manager.
  #
  # Upstream `pkgs.clamav` ships only the engine — no `freshclam.conf`,
  # no `clamd.conf`, no signature DBs. The binaries hard-code
  # `/etc/clamav/<tool>.conf` as the default config path, which on a
  # home-manager-only install is missing.
  #
  # This module fixes that by wrapping the four user-facing ClamAV
  # binaries (`freshclam`, `clamd`, `clamscan`, `clamdscan`) so they:
  #   1. Resolve a writable state directory at runtime under
  #      `$XDG_DATA_HOME/clamav/` (default `~/.local/share/clamav`).
  #      Per-user, no `/etc/`, no root required.
  #   2. Generate a working config on first invocation with paths
  #      pointing at that user-owned directory. Re-generated only when
  #      the config is missing, so manual edits stick.
  #   3. `exec` the real upstream binary with `--config-file` injected,
  #      so all ClamAV flags still pass through.
  #
  # One-shot bootstrap: `clamav-init` runs `freshclam` if no signature
  # DB is present. Run it once after a fresh install (or after GC'ing
  # `~/.local/share/clamav/db`).
  #
  # Periodic updates are NOT scheduled. The daemon (`clamd`) is still
  # intentionally not enabled — `clamdscan` will error until you start
  # `clamd` yourself (e.g. via a systemd/launchd user service).
  #
  # What this module installs:
  #   clamav (slim)          — engine copy with `freshclam`/`clamd`/
  #                            `clamscan`/`clamdscan` stripped, so its
  #                            bin/ doesn't collide with the wrappers.
  #                            Provides `clambc`, `clamconf`, `clamdtop`,
  #                            `sigtool` plus the shared libs.
  #                            Wrappers below exec the full `pkgs.clamav`
  #                            binary directly, so the slim copy is only
  #                            for PATH exposure.
  #   clamav-unofficial-sigs  — third-party signature updater
  #                            (Sanesecurity, MalwarePatrol, URLhaus, …).
  #                            Lives in `pkgs/custom`.
  #   freshclam, clamd,      — stable wrappers (see above) that
  #   clamscan, clamdscan      auto-generate per-user configs.
  #   clamav-init            — bootstrap helper for first-run DB.
  #   yara-scan              — `yr scan` against the Yara-Rules/rules
  #                            community ruleset (pkgs/custom/yara-rules).
  #                            Note: bare `yr` is NOT on PATH — only the
  #                            wrapper, which loads the ruleset for you.
  #   trivy, yara-x          — NOT installed here. Available in `pkgs` if
  #                            you need them; add to home.packages below.
  # yaraScan: preloads the Yara-Rules/rules community ruleset so the user
  # doesn't have to pass the rules path every invocation. Named
  # `yara-scan` (not `yr`) so the bare `yr` command stays available for
  # ad-hoc / custom rules.
  #
  # yara-x compatibility: yara-x covers most rules but drops support for
  # some legacy modules (notably `pe`, `dotnet`, `math`), which some
  # Yara-Rules/rules files still use. Expect a few rules to fail to
  # compile under `yr scan` — errors are non-fatal, valid rules still
  # scan.
  yaraScan = pkgs.writeShellScriptBin "yara-scan" ''
    exec ${pkgs.yara-x}/bin/yr scan ${pkgs.custom.yara-rules} "$@"
  '';

  # Wrap a ClamAV tool with our stable config. `extraConfig` is appended
  # verbatim to the generated conf — used to add tool-specific knobs
  # (DatabaseMirror for freshclam, LocalSocket for clamd, etc.).
  clamavTool = tool: extraConfig:
    pkgs.writeShellScriptBin tool ''
          set -euo pipefail
          : "''${XDG_DATA_HOME:=$HOME/.local/share}"
          DATA="$XDG_DATA_HOME/clamav"
          mkdir -p "$DATA/db" "$DATA/log" "$DATA/run"
          CONF="$DATA/${tool}.conf"

          if [[ ! -f "$CONF" ]]; then
            cat > "$CONF" <<EOF
      DatabaseDirectory $DATA/db
      UpdateLogFile $DATA/log/${tool}.log
      PidFile $DATA/run/${tool}.pid
      Foreground false
      ${lib.strings.trim extraConfig}
      EOF
          fi

          exec ${pkgs.clamav}/bin/${tool} --config-file "$CONF" "$@"
    '';

  freshclam = clamavTool "freshclam" ''
    Checks 24
    DatabaseMirror db.local.clamav.net
    DatabaseMirror database.clamav.net
  '';

  clamd = clamavTool "clamd" ''
    LocalSocket $DATA/run/clamd.ctl
    FixStaleSocket true
  '';

  clamscan = clamavTool "clamscan" "";

  clamdscan = clamavTool "clamdscan" "";

  # Bootstrap the signature DB on first run. Idempotent — no-op if
  # main.cvd or main.cld is already present in the DB directory.
  clamavInit = pkgs.writeShellScriptBin "clamav-init" ''
    set -euo pipefail
    : "''${XDG_DATA_HOME:=$HOME/.local/share}"
    DATA="$XDG_DATA_HOME/clamav"
    mkdir -p "$DATA/db" "$DATA/log" "$DATA/run"
    if [[ -f "$DATA/db/main.cvd" ]] || [[ -f "$DATA/db/main.cld" ]]; then
      echo "ClamAV: signature DB already present at $DATA/db"
      exit 0
    fi
    echo "ClamAV: bootstrapping signature DB at $DATA/db ..."
    exec ${freshclam}/bin/freshclam
  '';

  # `pkgs.clamav` ships all eight binaries; our wrappers shadow four
  # (`freshclam`, `clamd`, `clamscan`, `clamdscan`) with per-user configs.
  # home-manager builds its PATH via `pkgs.buildEnv` without
  # `ignoreCollisions`, so we can't ship both into `home.packages`.
  # Build a slim copy that drops just the four colliding binaries —
  # keeps `clambc`, `clamconf`, `clamdtop`, `sigtool`, and the libs
  # available on PATH. Wrappers still `exec ${pkgs.clamav}/bin/${tool}`
  # directly, so they don't depend on this slim copy at runtime.
  clamavEngine = pkgs.runCommand "clamav-engine" {} ''
    mkdir -p "$out"
    cp -R ${pkgs.clamav}/. "$out/"
    chmod -R u+w "$out"
    for bin in freshclam clamd clamscan clamdscan; do
      rm -f "$out/bin/$bin"
    done
  '';
in {
  home.packages =
    [
      # Upstream ClamAV minus the four binaries our wrappers shadow.
      clamavEngine
      pkgs.custom.clamav-unofficial-sigs
      yaraScan
    ]
    ++ [
      freshclam
      clamd
      clamscan
      clamdscan
      clamavInit
    ];
}
