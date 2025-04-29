{
  currentProfileDir,
  fx-autoconfig,
  ...
}: {
  imports = [
    ./CSS
  ];

  ## fx-autoconfig
  home.file."${currentProfileDir}/chrome/JS" = {
    source = ./JS;
    recursive = true;
  };
  home.file."${currentProfileDir}/chrome/resources" = {
    source = fx-autoconfig + "/profile/chrome/resources";
    recursive = true;
  };
  home.file."${currentProfileDir}/chrome/utils" = {
    source = fx-autoconfig + "/profile/chrome/utils";
    recursive = true;
  };
}