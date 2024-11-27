{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.hyprpanel.packages."x86_64-linux".hyprpanel
  ];
}
