# Here goes my ZSH stuffs:

{ pkgs, config, lib, ... }@inputs:
{
  programs.zsh = {
    # Enable ZSH:
    enable = true;

    # Setup the plugins:
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtraFirst = "source ~/.p10k.zsh";
    initExtra = ''
      neofetch
      echo "\n(^.^) Welcome back, Jakku Night!\n"
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
