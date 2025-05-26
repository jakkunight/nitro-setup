# NerdFonts:
{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  options = {
    graphics.fonts = {
      enable = lib.mkEnableOption "Enable custom fonts.";
    };
  };
  config = {
    fonts.packages = with pkgs; [
      # Old installation:
      # (nerdfonts.override { fonts = [ "CascadiaCode" "Hack" "FiraCode" "Ubuntu" "Iosevka" ]; })
      nerd-fonts.overpass
      nerd-fonts.hack
      nerd-fonts.iosevka
      nerd-fonts.fira-mono
      nerd-fonts.fira-code
      nerd-fonts.caskaydia-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.zed-mono
      nerd-fonts.ubuntu-sans
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu
      nerd-fonts.departure-mono
      nerd-fonts.bigblue-terminal
      nerd-fonts.hasklug
      nerd-fonts.profont
      inputs.genshin-font.packages.${pkgs.system}.default
      cozette
    ];
  };
}
