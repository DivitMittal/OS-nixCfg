{
  config,
  lib,
  pkgs,
  hostPlatform,
  ...
}: let
  cfg = config.programs.tidalcycles;

  # SuperCollider path varies by platform
  # On macOS: installed via brewCasks to ~/Applications
  # On Linux: installed via nixpkgs
  scPath =
    if hostPlatform.isDarwin
    then "${pkgs.brewCasks.supercollider}/Applications/SuperCollider.app/Contents/MacOS/sclang"
    else "${pkgs.supercollider}/bin/sclang";

  # SuperCollider is only available in nixpkgs on Linux
  supercolliderAvailable = hostPlatform.isLinux;

  # SuperCollider script for installing SuperDirt
  installScript = pkgs.writeText "install-superdirt.scd" ''
    Quarks.install("SuperDirt");
    Quarks.install("Vowel");
    0.exit;
  '';

  # SuperCollider script for starting SuperDirt
  startScript = pkgs.writeText "start-superdirt.scd" ''
    (
      s.reboot {
        s.options.numBuffers = 1024 * 256;
        s.options.memSize = 8192 * 32;
        s.options.numWireBufs = 128;
        s.options.maxNodes = 1024 * 32;
        s.options.numOutputBusChannels = 2;
        s.options.numInputBusChannels = 2;
        s.waitForBoot {
          ~dirt = SuperDirt(2, s);
          ~dirt.loadSoundFiles;
          ~dirt.start(57120, 0 ! 12);
          "SuperDirt started on port 57120".postln;
        };
      };
    )
  '';

  # SC3-Plugins installation script
  # Run this once to install SC3-Plugins for SuperCollider
  install-sc3-plugins = pkgs.writeShellScriptBin "install-sc3-plugins" ''
    ${lib.optionalString hostPlatform.isDarwin ''
      SC3_PLUGINS_VERSION="3.13.0"
      SC3_PLUGINS_URL="https://github.com/supercollider/sc3-plugins/releases/download/Version-$SC3_PLUGINS_VERSION/sc3-plugins-$SC3_PLUGINS_VERSION-macOS.zip"
      EXTENSIONS_DIR="$HOME/.local/share/SuperCollider/Extensions"

      echo "Installing SC3-Plugins version $SC3_PLUGINS_VERSION..."

      # Create extensions directory if it doesn't exist
      mkdir -p "$EXTENSIONS_DIR"

      # Download and extract
      TEMP_DIR=$(mktemp -d)
      cd "$TEMP_DIR"

      echo "Downloading sc3-plugins..."
      ${pkgs.curl}/bin/curl -L -o sc3-plugins.zip "$SC3_PLUGINS_URL"

      echo "Extracting to temporary directory..."
      ${pkgs.unzip}/bin/unzip -q sc3-plugins.zip

      echo "Installing to $EXTENSIONS_DIR..."
      # The zip contains sc3-plugins/SC3plugins/
      # Move SC3plugins contents directly to Extensions directory
      # This ensures SuperCollider can find them
      if [ -d "sc3-plugins/SC3plugins" ]; then
        # Use rsync to copy and exclude macOS resource fork files (._*)
        ${pkgs.rsync}/bin/rsync -av --exclude='._*' sc3-plugins/SC3plugins/ "$EXTENSIONS_DIR/"
      fi

      # Also copy README if it exists (but not ._README.txt)
      if [ -f "sc3-plugins/README.txt" ]; then
        cp sc3-plugins/README.txt "$EXTENSIONS_DIR/"
      fi

      # Cleanup
      cd /
      rm -rf "$TEMP_DIR"

      echo "SC3-Plugins installed successfully!"
      echo "Restart SuperCollider or run 'start-superdirt' to use the new plugins."
    ''}

    ${lib.optionalString hostPlatform.isLinux ''
      echo "On Linux, sc3-plugins should be installed via nixpkgs."
      echo "This is not yet implemented for Linux."
      exit 1
    ''}
  '';

  # SuperDirt installation script
  # Run this once to install SuperDirt quarks in SuperCollider
  install-superdirt = pkgs.writeShellScriptBin "install-superdirt" ''
    ${lib.optionalString hostPlatform.isDarwin ''
      if [ ! -f "${scPath}" ]; then
        echo "ERROR: SuperCollider not found at ${scPath}"
        echo "Run: hms"
        exit 1
      fi
    ''}
    echo "Installing SuperDirt quarks for SuperCollider..."
    ${scPath} ${installScript}
    echo "SuperDirt installed! Now run 'start-superdirt' to launch the audio engine."
  '';

  # Start SuperDirt audio engine
  start-superdirt = pkgs.writeShellScriptBin "start-superdirt" ''
    ${lib.optionalString hostPlatform.isDarwin ''
      if [ ! -f "${scPath}" ]; then
        echo "ERROR: SuperCollider not found at ${scPath}"
        echo "Run: hms"
        exit 1
      fi

      # Check for sc3-plugins
      EXTENSIONS_DIR="$HOME/.local/share/SuperCollider/Extensions"
      if [ ! -d "$EXTENSIONS_DIR/JoshUGens" ] && [ ! -d "$EXTENSIONS_DIR/MdaUGens" ]; then
        echo "ERROR: SC3-Plugins not found in SuperCollider Extensions"
        echo "SuperDirt requires SC3-Plugins to be installed."
        echo ""
        echo "Please run: install-sc3-plugins"
        echo ""
        echo "Then restart SuperCollider or rerun this command."
        exit 1
      fi
    ''}
    echo "Starting SuperDirt audio engine..."
    echo "Keep this terminal open while using TidalCycles"
    echo ""
    ${scPath} ${startScript}
  '';

  # TidalCycles GHCI startup script
  tidal-boot = pkgs.writeText "BootTidal.hs" ''
    :set -XOverloadedStrings
    :set prompt ""

    import Sound.Tidal.Context

    tidal <- startTidal (superdirtTarget {oLatency = 0.1, oAddress = "127.0.0.1", oPort = 57120}) (defaultConfig {cVerbose = True, cFrameTimespan = 1/20})

    let p = streamReplace tidal
    let hush = streamHush tidal
    let d1 = p 1
    let d2 = p 2
    let d3 = p 3
    let d4 = p 4
    let d5 = p 5
    let d6 = p 6
    let d7 = p 7
    let d8 = p 8
    let d9 = p 9
    let d10 = p 10
    let d11 = p 11
    let d12 = p 12
    let list = streamList tidal
    let mute = streamMute tidal
    let unmute = streamUnmute tidal
    let solo = streamSolo tidal
    let unsolo = streamUnsolo tidal
    let once = streamOnce tidal
    let asap = streamOnce tidal
    let nudgeAll = streamNudgeAll tidal
    let all = streamAll tidal
    let resetCycles = streamResetCycles tidal
    let setcps = asap . cps
    let xfade i = transition tidal True (Sound.Tidal.Transition.xfadeIn 4) i
    let xfadeIn i t = transition tidal True (Sound.Tidal.Transition.xfadeIn t) i
    let histpan i t = transition tidal True (Sound.Tidal.Transition.histpan t) i
    let wait i t = transition tidal True (Sound.Tidal.Transition.wait t) i
    let waitT i f t = transition tidal True (Sound.Tidal.Transition.waitT f t) i
    let jump i = transition tidal True (Sound.Tidal.Transition.jump) i
    let jumpIn i t = transition tidal True (Sound.Tidal.Transition.jumpIn t) i
    let jumpIn' i t = transition tidal True (Sound.Tidal.Transition.jumpIn' t) i
    let jumpMod i t = transition tidal True (Sound.Tidal.Transition.jumpMod t) i
    let mortal i lifespan release = transition tidal True (Sound.Tidal.Transition.mortal lifespan release) i
    let interpolate i = transition tidal True (Sound.Tidal.Transition.interpolate) i
    let interpolateIn i t = transition tidal True (Sound.Tidal.Transition.interpolateIn t) i
    let clutch i = transition tidal True (Sound.Tidal.Transition.clutch) i
    let clutchIn i t = transition tidal True (Sound.Tidal.Transition.clutchIn t) i
    let anticipate i = transition tidal True (Sound.Tidal.Transition.anticipate) i
    let anticipateIn i t = transition tidal True (Sound.Tidal.Transition.anticipateIn t) i
    let forId i t = transition tidal False (Sound.Tidal.Transition.mortalOverlay t) i

    :set prompt "tidal> "
    :set prompt-cont ""
  '';

  # TidalCycles REPL launcher
  tidal-repl = pkgs.writeShellScriptBin "tidal-repl" ''
    echo "Starting TidalCycles REPL..."
    echo "Make sure SuperDirt is running (use 'start-superdirt' command)"
    echo ""
    ${pkgs.haskellPackages.ghcWithPackages (p: [p.tidal])}/bin/ghci -ghci-script ${tidal-boot}
  '';

  # sclang wrapper for SuperCollider
  sclang = pkgs.writeShellScriptBin "sclang" ''
    exec ${scPath} "$@"
  '';
in {
  options.programs.tidalcycles = {
    enable = lib.mkEnableOption "TidalCycles live coding environment";

    package = lib.mkPackageOption pkgs.haskellPackages "tidal" {nullable = true;};

    installHelperScripts = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Install helper scripts for managing TidalCycles:
        - install-superdirt: Install SuperDirt quarks in SuperCollider
        - start-superdirt: Start SuperDirt audio engine
        - tidal-repl: Launch TidalCycles REPL
        - install-sc3-plugins: Install SC3-Plugins (macOS only)
        - sclang: SuperCollider language wrapper
      '';
    };

    installSupercollider = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Install SuperCollider.
        On Linux, this installs from nixpkgs.
        On macOS, this installs via brewCasks.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.attrsets.attrValues (
      (lib.optionalAttrs (cfg.package != null) {
        inherit (pkgs.haskellPackages) tidal;
      })
      // (lib.optionalAttrs cfg.installHelperScripts {
        inherit install-superdirt start-superdirt tidal-repl install-sc3-plugins sclang;
      })
      // (lib.optionalAttrs (cfg.installSupercollider && supercolliderAvailable) {
        inherit (pkgs) supercollider;
      })
      // (lib.optionalAttrs (cfg.installSupercollider && hostPlatform.isDarwin) {
        inherit (pkgs.brewCasks) supercollider;
      })
    );
  };
}
