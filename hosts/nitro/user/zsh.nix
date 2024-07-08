# Here goes my ZSH stuffs:

{ pkgs, config, lib, ... }@inputs:
{
  programs.zsh = {
    # Enable ZSH:
    enable = true;

    # Setup the plugins:
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };
}
