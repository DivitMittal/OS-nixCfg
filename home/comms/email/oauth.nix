{pkgs, ...}: {
  home.packages = let
    mutt = pkgs.fetchFromGitHub {
      owner = "muttmua";
      repo = "mutt";
      rev = "master";
      hash = "sha256-GiN1WjHzTICFOFCEqb39MWGu3EfxE4uvgN7hpjdpfrI=";
    };
    # Patch the empty client_id/client_secret fields in the registrations dict.
    #
    # Microsoft: Thunderbird's production app ID (public, uses PKCE — no secret needed):
    #   https://hg.mozilla.org/comm-central/file/tip/mailnews/base/src/OAuth2Providers.sys.mjs
    #   microsoft365ProductionAppId = "9e5f94bc-e8a4-4e73-b8be-63364c29d753"
    #
    # Google: confidential client — requires both client_id AND client_secret.
    #   Unlike Microsoft/PKCE, Google does not support public clients without a secret.
    #   Register a Desktop app at https://console.cloud.google.com → APIs & Services → Credentials
    #   Enable: Gmail API. Set GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET before building.
    googleClientId = builtins.getEnv "GOOGLE_CLIENT_ID";
    googleClientSecret = builtins.getEnv "GOOGLE_CLIENT_SECRET";
    patchedScript = pkgs.runCommand "mutt_oauth2_patched.py" {} ''
            ${pkgs.python3}/bin/python3 - <<PYEOF
      import re

      with open("${mutt}/contrib/mutt_oauth2.py") as f:
          content = f.read()

      # Patch Microsoft client_id with Thunderbird's production app ID
      content = re.sub(
          r"('microsoft'[^}]*?'client_id':\s*)'[^']*'",
          r"\g<1>'9e5f94bc-e8a4-4e73-b8be-63364c29d753'",
          content,
          flags=re.DOTALL
      )

      # Patch Google client_id and client_secret with personal GCP credentials.
      # Also fix the deprecated OOB redirect_uri — localhostauthcode flow overrides
      # it at runtime (line ~187), but set a sane default for authcode flow too.
      content = re.sub(
          r"('google'[^}]*?'client_id':\s*)'[^']*'",
          r"\g<1>'${googleClientId}'",
          content,
          flags=re.DOTALL
      )
      content = re.sub(
          r"('google'[^}]*?'client_secret':\s*)'[^']*'",
          r"\g<1>'${googleClientSecret}'",
          content,
          flags=re.DOTALL
      )

      # Patch encryption/decryption pipes to use rage with a dedicated age identity
      rage = "${pkgs.rage}/bin/rage"
      identity = "str(Path('~/.local/share/oauth2/identity.key').expanduser())"
      content = content.replace(
          "ENCRYPTION_PIPE = ['gpg', '--encrypt', '--recipient', 'YOUR_GPG_IDENTITY']",
          f"ENCRYPTION_PIPE = ['{rage}', '-e', '-i', {identity}]"
      )
      content = content.replace(
          "DECRYPTION_PIPE = ['gpg', '--decrypt']",
          f"DECRYPTION_PIPE = ['{rage}', '-d', '-i', {identity}]"
      )

      with open("$out", "w") as f:
          f.write(content)
      PYEOF
    '';
  in [
    # Usage (one-time per account):
    #   oauth2 ~/.local/share/oauth2/<email> --authorize
    #   Microsoft: registration → microsoft | flow → localhostauthcode or devicecode
    #   Google:    registration → google    | flow → localhostauthcode
    (pkgs.writeShellScriptBin "oauth2" ''
      exec ${pkgs.python3}/bin/python3 ${patchedScript} "$@"
    '')
  ];
}
