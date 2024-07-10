# Here goes my NerdFonts:
{ config, lib, pkgs, ... }@inputs: {
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" "Hack" "FiraCode" "Ubuntu" "Iosevka" ]; })
  ];
}
