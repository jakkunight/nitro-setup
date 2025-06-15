# ZSH config:
{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    # Enable ZSH:
    enable = true;

    # Setup the plugins:
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    #initExtraFirst = "source ~/.p10k.zsh";
    initContent = ''
      fastfetch
      echo "\n(^.^) Welcome back, Jakku Night!\n"
    '';
    plugins = [
      # {
      #   name = "powerlevel10k";
      #   src = pkgs.zsh-powerlevel10k;
      #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
    ];
  };
}
