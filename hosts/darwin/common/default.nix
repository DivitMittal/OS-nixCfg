{ lib, pkgs, inputs, ... }:

{
  imports = [
    ./../../common
  ];

  nix.settings = {
	  "use-xdg-base-directories" = false;
  };

  nixpkgs.hostPlatform = "x86_64-darwin";

  services.nix-daemon.enable = true;  # Auto upgrade nix package and the daemon service.

  time.timeZone = "Asia/Calcutta";

  networking = {
    knownNetworkServices = ["Wi-Fi"];
    dns                  = ["1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001"];
  };

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    checks = {
      verifyBuildUsers = true; verifyNixChannels = true; verifyNixPath = true;
    };
    stateVersion = 4;                                                        # $ darwin-rebuild changelog
  };

  environment = {
    systemPackages = builtins.attrValues {
      inherit(pkgs)
        nixfmt-rfc-style                                                                                                    # Nix goodies
        bashInteractive zsh dash fish babelfish                                                                             # shells
        ed gnused nano vim                                                                                                  # editors
        bc binutils diffutils findutils inetutils gnugrep gawk groff which gzip gnupatch screen gnutar indent gnumake wget  # GNU
        curl git less;                                                                                                      # Other
      gcc = lib.hiPrio pkgs.gcc;
    };
    extraOutputsToInstall = [ "doc" "info" "devdoc" ];
  };

  environment = {
    shells = with pkgs;[bashInteractive zsh dash fish];
    loginShell = "${pkgs.zsh}";
  };

  documentation = {
    enable      = true;
    doc.enable  = true; info.enable = true; man.enable  = true;
  };

  programs = {
    nix-index.enable = true;
    man.enable       = true; info.enable      = true;
  };

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}