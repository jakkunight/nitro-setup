# Here goes the internationalization settings:
{ config, lib, pkgs, inputs, ... }: {
  # Set Keyboard layout>
  services.xserver.xkb.layout = "latam";
  # Select internationalisation properties.
  i18n.defaultLocale = "es_PY.UTF-8";
  console = {
    font = "Overpass";
    #   keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };
}
