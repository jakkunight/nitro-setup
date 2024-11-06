{config, lib, pkgs, inputs, ...}:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "yy";
    # package = pkgs.yazi.override {
    #   _7zz = (pkgs._7zz.override { useUasm = true; });
    # };
    package = inputs.old-yazi;
  };
}
