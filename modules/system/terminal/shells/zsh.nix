# ZSH config:
{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    terminal.shells.zsh = {
      enable = lib.mkEnableOption "Enable the ZSH config module";
      default = lib.mkEnableOption "Weather if ZSH is your default shell";
    };
  };
  config = lib.mkIf config.terminal.shells.zsh.enable {
    users.defaultUserShell = lib.mkIf config.terminal.shells.zsh.default pkgs.zsh;
    programs.zsh = {
      enable = true;
      enableLsColors = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
