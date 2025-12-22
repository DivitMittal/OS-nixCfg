{pkgs, ...}: {
  user = rec {
    uid = 10732;
    gid = uid;
    shell = "${pkgs.fish}/bin/fish";
  };
}
