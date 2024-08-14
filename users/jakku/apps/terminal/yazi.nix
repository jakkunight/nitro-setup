{config, lib, pkgs, ...}@inputs:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";
  };
}
