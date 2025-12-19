{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      uv #pipx
      ;
    pip-uninstall-all = pkgs.writeShellScriptBin "pip-uninstall-all" ''
      pip3 freeze | cut -d='@' -f1 | xargs pip3 uninstall -y
    '';
  };
}
