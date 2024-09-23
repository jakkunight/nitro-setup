{ pkgs, lib, config, inputs, ... }:

{
  home.packages = with pkgs; [
    nushell
    nushellFull
    nushellPlugins
  ];
}
