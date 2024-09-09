{ pkgs, lib, config, ... }@inputs:
{
  # Install Heimdall, needed to root Samsung devices:
  home.packages = [
    pkgs.heimdall
    pkgs.heimdall-gui
  ];
}
