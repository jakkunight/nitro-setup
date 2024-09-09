{ pkgs, lib, config, ... }@inputs:
{
  # Install Heimdall, needed to root Samsung devices:
  home.packages = with pkgs; [
    heimdall-gui
  ];
}
