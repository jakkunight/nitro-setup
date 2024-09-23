{ pkgs, lib, config, inputs, ... }:

{
  home.packages = with pkgs; [
    starship
  ];
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = ''
        $all
      '';
      scan_timeout = 10;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
