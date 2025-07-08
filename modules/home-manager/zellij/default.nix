{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "${pkgs.zsh}/bin/zsh";
    };
  };
}
