{ pkgs, lib, config, inputs, ... }:

{
  home.packages = with pkgs; [
    warp-terminal
  ];
}
