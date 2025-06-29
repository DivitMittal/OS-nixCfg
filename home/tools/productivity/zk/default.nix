{
  pkgs,
  config,
  ...
}: let
  enable = true;
in {
  xdg.configFile."zk/templates" = {
    inherit enable;
    source = ./templates;
    recursive = true;
  };

  programs.zk = {
    inherit enable;
    package = pkgs.zk;
    settings = {
      note = {
        language = "en";
        default-title = "Untitled";
        filename = "{{id}}";
        extension = ".md";
        template = "${config.xdg.configHome}/zk/templates/default.md";
        id-charset = "alphanum";
        id-length = 8;
        id-case = "lower";
      };
      extra = {
        author = "${config.hostSpec.userFullName}";
      };
      group = {
        daily = {
          paths = ["journal"];
          note = {
            filename = "{{format-date now '%Y-%m-%d'}}";
            extension = "md";
            template = "${config.xdg.configHome}/zk/templates/daily.md";
          };
        };
      };
      format = {
        markdown = {
          hashtags = true;
          colon-tags = false;
        };
      };
      tool = {
        editor = "${config.home.sessionVariables.EDITOR}";
        pager = "less -FIRX";
        fzf-preview = "bat -p --color always {-1}";
      };
      filter = {
        recents = "--sort created- --created-after 'last two weeks'";
      };
      alias = {
        # Edit the last modified note.
        edlast = "zk edit --limit 1 --sort modified- $argv";

        # Edit the notes selected interactively among the notes created the last two weeks.
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";

        # Show a random note.
        lucky = "zk list --quiet --format full --sort random --limit 1";

        # list notes for editing
        ls = "zk edit --interactive";

        # sear notes by tags
        t = "zk edit --interactive --tag $argv";

        config = ''nvim "$HOME/.dotfiles/zk/config.toml"'';

        # new journal entry
        daily = ''zk new --no-input "$ZK_NOTEBOOK_DIR/journal"'';

        # new note
        ne = ''zk new --no-input "$ZK_NOTEBOOK_DIR/ideas" --title $argv'';

        journal = "zk edit --sort created- $ZK_NOTEBOOK_DIR/journal --interactive";

        ideas = "zk edit --sort created- $ZK_NOTEBOOK_DIR/ideas --interactive";

        # remove a files
        rm = "zk list --interactive --quiet --format path --delimiter0 $argv | xargs -0 rm -vf --";

        # open last zk in slides
        slides = "zk list --interactive --quiet --format path --delimiter0 $argv | xargs -0 slides";
      };
      lsp = {
        diagnostics = {
          # Report titles of wiki-links as hints.
          wiki-title = "hint";
          # Warn for dead links between notes.
          dead-link = "error";
        };
      };
    };
  };
}
