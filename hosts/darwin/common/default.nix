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

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    checks = {
      verifyBuildUsers = true; verifyNixChannels = true; verifyNixPath = true;
    };
    stateVersion = 4;                                                        # $ darwin-rebuild changelog
  };

  networking = {
    knownNetworkServices = ["Wi-Fi"];
    dns = [
          "1.1.1.1"              "1.0.0.1"
    "2606:4700:4700::1111" "2606:4700:4700::1001"
    ];
  };

  environment = {
    systemPackages = builtins.attrValues {
      inherit(pkgs)
        binutils indent gnumake;
      gcc = lib.hiPrio pkgs.gcc;
    };
  };

  environment.loginShell = "${pkgs.zsh} -l";

  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}