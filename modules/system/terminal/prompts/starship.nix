# Starship prompt initial config:
{ lib, config, pkgs, ... }: {
  options = {
    terminal.prompts.starship = {
      enable = lib.mkEnableOption "Enable Starship prompt";
    };
  };
  config = lib.mkIf config.terminal.prompts.starship.enable {
    programs.starship = {
      enable = true;
      interactiveOnly = false;
      presets = [
        "nerd-font-symbols"
      ];
      settings = {
        format = lib.concatStrings [
          "[ ░▒▓](bold #769ff0)"
          "[  ](bold bg:#769ff0 fg:#090c0c)"
          "[](bold fg:#769ff0)"
          "$directory"
          "[󰅂 ](bold fg:#769ff0)"
          "$git_branch"
          "$git_status"
          "[󰅂](bold fg:#769ff0)"
          "$line_break"
          "[ 󰅂 ](bold fg:#769ff0)"
        ];
        directory = {
          style = "bold fg:#769ff0";
          format = "[ $path/]($style)";
          truncation_length = 10;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
            Desktop = "󰇄 ";
            "~" = "󱁍 ";
          };
        };

        scan_timeout = 10;
        character = {
          success_symbol = "[󰅂](bold green)";
          error_symbol = "[](bold red)";
        };
      };
    };
  };
}
