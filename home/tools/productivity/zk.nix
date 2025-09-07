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
        rev = "8d5e3bc9f5db68ef3b7f6326b71cefb5f9080417";
        hash = "sha256-zxzi2BkQDEOeQXsFkqvZxq/CMFT14J5JwNrneOKB25c=";
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
        template = "${config.xdg.configHome}/zk/templates/default.md";
        default-title = "Untitled";
        filename = "{{id}}";
        extension = "md";
        id-charset = "alphanum";
        id-length = 8;
        id-case = "lower";
      };
      format = {
        markdown = {
          hashtags = true;
          colon-tags = false;
        };
      };
      tool = {
        editor = "${config.home.sessionVariables.EDITOR}";
        pager = "${pkgs.glow}/bin/glow";
        fzf-preview = "${pkgs.bat}/bin/bat -p --color always {-1}";
      };
      extra.author = "${config.hostSpec.userFullName}";
      group = {
        daily = {
          paths = ["journal"];
          note = {
            template = "${config.xdg.configHome}/zk/templates/daily.md";
            filename = "{{format-date now '%Y-%m-%d'}}";
            extension = "md";
          };
        };
      };
      filter = {
        recents = "--sort created- --created-after 'last two weeks'";
      };
      alias = {
        # Edit the last modified note.
        last = "zk edit --limit 1 --sort modified- $argv";
        # Edit the notes selected interactively among the notes created the last two weeks.
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";
        # Show a random note.
        lucky = "zk list --quiet --format full --sort random --limit 1";
        # list notes for editing
        ls = "zk edit --interactive";
        # search notes by tags
        t = "zk edit --interactive --tag $argv";
        config = ''${config.home.sessionVariables.EDITOR} "${config.xdg.configHome}/zk/config.toml"'';
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
