{ pkgs, lib, config, inputs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
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
        "[󰅂 ](bold fg:#769ff0)"
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
          "~" = "󱁍";
        };
      };

      scan_timeout = 10;
      character = {
        success_symbol = "[󰅂](bold green)";
        error_symbol = "[](bold red)";
      };
    };
  };
}
