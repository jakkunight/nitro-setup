{ pkgs, lib, config, inputs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "HackNerdFont";
      size = 14;
      package = pkgs.nerd-fonts.hack;
    };
    settings = {
      enable_audio_bell = false;
    };
    shellIntegration = {
      enableZshIntegration = false;
      enableBashIntegration = false;
      enableFishIntegration = false;
    };
  };
}
