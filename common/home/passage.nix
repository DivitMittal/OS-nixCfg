{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.passage
    (pkgs.writeShellScriptBin "passage-fzf" ''
      set -eou pipefail
      PREFIX="''${PASSAGE_DIR:-$HOME/.passage/store}"
      FZF_DEFAULT_OPTS=""
      name="$(find "$PREFIX" -type f -name '*.age' | \
        sed -e "s|$PREFIX/||" -e 's|\.age$||' | \
        fzf --height 40% --reverse --no-multi)"
      ${pkgs.passage} "''${@}" "$name"
    '')
  ];

  home.sessionVariables = {
    PASSAGE_DIR = "${config.xdg.configHome}/passage";
    PASSAGE_IDENTITIES_FILE = "${config.age.secrets."id_passage".path}";
  };
}