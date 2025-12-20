{pkgs, ...}: {
  user = rec {
    uid = 10660;
    gid = uid;
    shell = "${pkgs.fish}/bin/fish";
  };
}
