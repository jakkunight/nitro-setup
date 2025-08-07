{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initContent = lib.mkBefore ''
      clear
      ${pkgs.fastfetch}/bin/fastfetch
      echo "Welcome back, $(whoami)! (^.^)"
    '';
  };
}
