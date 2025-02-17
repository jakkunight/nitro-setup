# Wofi config:
{ config, pkgs, lib, ... }:
{
  programs.wofi = {
    enable = true;
    settings = { };
    style = ''
      * {
        background-color: #1f2335;
        color: #7aa2f7;
        font-family: "Genshin Impact";
        font-size: 14pt;
      }
    '';
  };
}
