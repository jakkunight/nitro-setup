{config, lib, pkgs, ...}@inputs:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "yy";
  };
}
