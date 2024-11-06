# Here goes my NerdFonts:
{ pkgs, config, lib, inputs, ... }: {
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" "Hack" "FiraCode" "Ubuntu" "Iosevka" ]; })
    overpass
  ];
}
