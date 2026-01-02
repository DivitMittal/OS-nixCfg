{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.programs.claude-code;
in {
  options = {
    programs.claude-code = {
      output-styles = mkOption {
        type = types.attrsOf types.str;
        default = {};
        example = lib.literalExpression ''
          {
            concise = '''
              ---
              name: Concise
              description: Brief, to-the-point responses
              ---

              Provide direct answers with minimal explanation.
            ''';
          }
        '';
        description = ''
          Custom output styles for claude-code.

          Each attribute defines a custom output style as a markdown file with frontmatter.
          Files will be written to {file}`.claude/output-styles/`.

          See <https://code.claude.com/docs/en/output-styles> for more information.
        '';
      };
    };
  };

  config = mkIf (cfg.output-styles != {}) {
    home.file = lib.mapAttrs' (name: content:
      lib.nameValuePair ".claude/output-styles/${name}.md" {
        text = content;
      })
    cfg.output-styles;
  };
}
