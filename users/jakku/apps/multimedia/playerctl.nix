{ pkgs, config, lib, ... }@inputs:
{
  # Enable playerctl service:
  services.playerctl = {
    enable = true;
    package = pkgs.playerctl;
  };
}
