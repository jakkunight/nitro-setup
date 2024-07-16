# Here goes my NerdFonts:
{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" "Hack" "FiraCode" "Ubuntu" "Iosevka" ]; })
  ];
}
