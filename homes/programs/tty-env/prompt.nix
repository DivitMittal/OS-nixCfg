{ pkgs, lib, ... }:

let
  inherit(lib) mkAfter concatStrings;
in
{
  programs.bash.initExtra = mkAfter ''
    ## Prompt
    if [ "`id -u`" -eq 0 ]; then # ckeck for root user
      PS1="\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\w]> \[\e[0m\]"
    else
      PS1="\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\w]> \[\e[0m\]"
    fi
  '';

  programs.zsh.initExtra = mkAfter "PS1='%F{cyan}%~%f %# '";

  programs.starship = {
    enable = true;
    package = pkgs.starship;

    enableFishIntegration = true; enableZshIntegration  = false; enableBashIntegration = false; enableNushellIntegration = false; enableInteractive = true;

    settings = {
      format = concatStrings [
        "[╭─sys─-➜❯](bold blue) " "$sudo" "$username" "$hostname" "$shell" "\${custom.yazi}" "$status" "$custom" "$cmd_duration" "$docker_context" "\n"
        "[┣─pwd─-➜❯](bold red) "  "$directory" "$git_branch" "$git_commit" "$git_status" "\n"
        "[╰─cmd─➜❯](bold green) " "$character"
      ];
      right_format = concatStrings [
        "$nix_shell"
        "$lua"
        "$rust"
        "$java"
        "$kotlin"
        "$dart"
        "$python"
        "$golang"
        "$swift"
        "$nodejs"
        "$php"
        "$conda"
        "$package"
      ];

      add_newline     = true;
      command_timeout = 425;
      scan_timeout    = 50; # scaning files in the current directory

      character = {
        disabled       = false;
        error_symbol   = "[✗](bold red)";
        format         = "$symbol ";
        success_symbol = "[➜](bold green)";
        vicmd_symbol   = "[V](bold blue)";
      };
      username = {
        disabled    = false;
        format      = "[$user]($style)";
        show_always = true;
        style_root  = "red bold";
        style_user  = "italic bright-purple";
      };
      hostname = {
        disabled = false;
        format   = "[@](bold blue)[$hostname](bold red) ";
        ssh_only = false;
        trim_at  = ".";
      };
      directory = {
        disabled          = false;
        home_symbol       = "🏡";
        style             = "white";
        truncate_to_repo  = false;
        truncation_length = 10;
        truncation_symbol = "…/";
      };
      cmd_duration = {
        disabled          = false;
        format            = "took [$duration](bold yellow) ";
        show_milliseconds = true;
      };
      package = {
        disabled = false;
        format = "[🎁 $version](208 bold) ";
      };
      shell = {
        disabled             = false;
        bash_indicator       = "🐑";
        fish_indicator       = "🐠";
        format               = "via $indicator ";
        powershell_indicator = "_";
        unknown_indicator    = "❓";
        zsh_indicator        = "🦓";
      };
      status = {
        disabled = true;
        format   = "[\\[$symbol$status\\]]($style) ";
        style    = "red";
        symbol   = "💥 ";
      };
      sudo = {
        disabled = false;
        format   = "$symbol";
        style    = "bold green";
        symbol   = "🧙";
      };
      git_branch = {
        disabled           = false;
        always_show_remote = true;
        format             = "on 🌱:[$branch](bold yellow) 🎋:[$remote_name/$remote_branch](bold blue) ";
      };
      git_commit = {
        disabled      = true;
        only_detached = false;
        style         = "red";
        tag_disabled  = false;
      };
      git_status = {
        disabled = false;
        ahead      = "🏃\\([$count](bold blue)\\)";
        behind     = "🐌\\([$count](bold blue)\\)";
        conflicted = "🤔";
        deleted    = "🚮";
        diverged   = "😵\\(\\(🏃[$ahead_count](bold blue)\\);🐌\\([$behind_count](bold blue)\\)\\)";
        modified   = "📝";
        renamed    = "🐣";
        staged     = "🎤\\([$count](bold blue)\\)";
        stashed    = "📦";
        untracked  = "👀";
      };

      ## External
      swift  = { disabled = false; };
      rust   = { disabled = false; };
      php    = { disabled = false; };
      python = { disabled = false; };
      nodejs = { disabled = false; };
      java   = { disabled = false; };
      kotlin = { disabled = false; };
      lua    = { disabled = false; };
      golang = { disabled = false; };
      dart   = { disabled = false; };
      nix_shell = {
        disabled    = false;
        format      = "via [☃️ $state( \\($name\\))](bold blue) ";
        impure_msg  = "[impure shell](bold red)";
        pure_msg    = "[pure shell](bold green)";
        unknown_msg = "[unknown shell](bold yellow)";
      };

      custom.yazi = {
        disabled    = false;
        description = "Indicate the shell was launched by `yazi`";
        symbol      = "on Y ";
        when        = ''test -n "$YAZI_LEVEL"'';
      };

      ## Disabled
      battery = {
        disabled           = true;
        charging_symbol    = "⚡️";
        discharging_symbol = "💦";
        display            = [{ threshold = 100; }];
        format             = "🔋:$symbol ";
        full_symbol        = "💪";
        unknown_symbol     = "💡";
      };

      time = {
        disabled = true;
        format   = "@ ⏰:[\\[$time\\]](bold yellow) ";
        use_12hr = true;
      };

      docker_context = { disabled = true; };

      custom.docker = {
        disabled    = true;
        description = "Shows a  docker symbol if the current directory has Dockerfile or docker-compose.yml files";
        files       = [ "Dockerfile" "docker-compose.yml" "docker-compose.yaml" ];
        format      = "with $symbol ";
        symbol      = "🐳";
      };

      conda = {
        disabled    = true;
        format      = "in [$symbol$environment](dimmed green) ";
        ignore_base = true;
      };
    };
  };
}