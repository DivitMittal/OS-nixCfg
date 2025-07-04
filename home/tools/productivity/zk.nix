{
  pkgs,
  config,
  ...
}: let
  enable = true;
  templates =
    (
      pkgs.fetchFromGitHub {
        owner = "DivitMittal";
        repo = "PKMS";
        rev = "e1b097e7c3c05d2a66210bfeeadef75feb3dcb5f";
        hash = "sha256-uXH29PBoPwpjFm0Bfh7LaLcXv2onDOjK/1wVN7OxGr4=";
      }
    )
    + "/etc/zk/templates";
in {
  xdg.configFile."zk/templates" = {
    inherit enable;
    source = templates;
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
        extension = "md";
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
        # search notes by tags
        t = "zk edit --interactive --tag $argv";
        config = ''nvim "${config.xdg.configHome}/zk/config.toml"'';
        ## Inbox & Journal
        daily = ''zk new --no-input "$ZK_NOTEBOOK_DIR/journal"'';
        ne = ''zk new --no-input "$ZK_NOTEBOOK_DIR/inbox" --title $argv'';
        journal = "zk edit --sort created- $ZK_NOTEBOOK_DIR/journal --interactive";
        inbox = "zk edit --sort created- $ZK_NOTEBOOK_DIR/inbox --interactive";
        # remove a files
        rm = "zk list --interactive --quiet --format path --delimiter0 $argv | xargs -0 rm -vf --";
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
