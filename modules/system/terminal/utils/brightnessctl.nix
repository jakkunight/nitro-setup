# Brightnessctl:
{ lib, config, pkgs, ... }: {
  config = {
    environment.systemPackages = [
      pkgs.brightnessctl
    ];
  };
}

