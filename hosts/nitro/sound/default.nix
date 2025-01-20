{ pkgs, lib, config, ... }@inputs: {
  imports = [
    ./alsa.nix
    ./pipewire.nix
  ];
}
