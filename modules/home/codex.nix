{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types literalExpression;
  cfg = config.programs.codex;
in {
  options.programs.codex = {
    skills = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = literalExpression ''
        {
          skill-creator = '''
            ---
            name: skill-creator
            description: Create new skills for Codex
            ---

            You are a skill creator assistant.
            Help users create new Codex skills with proper SKILL.md format.
          ''';
        }
      '';
      description = ''
        Custom skills for Codex CLI.

        Each attribute defines a skill. The attribute name becomes the skill directory name,
        and the value is the SKILL.md content with YAML frontmatter.
        Skills are stored in {file}`$XDG_CONFIG_HOME/codex/skills/<name>/SKILL.md`.

        See <https://github.com/openai/codex> for skill format documentation.
      '';
    };

    prompts = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = literalExpression ''
        {
          explain = '''
            ---
            description: Explain code in detail
            argument-hint: <file-or-symbol>
            ---

            Provide a detailed explanation of the specified code.
          ''';
        }
      '';
      description = ''
        Custom prompts for Codex CLI.

        Each attribute defines a custom prompt. The attribute name becomes the prompt filename,
        and the value is the prompt content with optional YAML frontmatter.
        Prompts are stored in {file}`$XDG_CONFIG_HOME/codex/prompts/<name>.md`.
      '';
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = lib.mkMerge [
      # Skills: each skill gets its own directory with SKILL.md
      (lib.mapAttrs' (name: content:
        lib.nameValuePair "codex/skills/${name}/SKILL.md" {
          text = content;
        })
      cfg.skills)

      # Prompts: each prompt is a markdown file
      (lib.mapAttrs' (name: content:
        lib.nameValuePair "codex/prompts/${name}.md" {
          text = content;
        })
      cfg.prompts)
    ];
  };
}
