{ pkgs, lib, config, ... }@inputs:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
