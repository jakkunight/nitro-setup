{ pkgs, config, lib, ... }@inputs:
{
  # Enable playerctl service:
  services.playerctld = {
    enable = true;
    package = pkgs.playerctl;
  };
}
