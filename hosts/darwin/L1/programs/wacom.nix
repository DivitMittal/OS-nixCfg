{pkgs, ...}: {
  homebrew.casks = [
    {
      name = "wacom-tablet";
      greedy = false;
    }
  ];

  environment.systemPackages = [pkgs.customDarwin.wacom-toggle];
}