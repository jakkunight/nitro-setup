# Here comes some academic tools for the University:
{ config, lib, pkgs, ... }@inputs:
{
  home.packages = with pkgs; [

    libreoffice
  ];
}
