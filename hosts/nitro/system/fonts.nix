# Here goes my NerdFonts:
{ config, lib, pkgs, ... }@inputs: {
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "Ubuntu" "Iosevka" ]; })
  ];
}
