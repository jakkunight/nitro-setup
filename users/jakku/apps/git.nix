# Here goes my git credentials:
{ config, pkgs, ... }@inputs:
{
  programs.git = {
    enable = true;
    userName = "Jakku Night";
    userEmail = "R101g117l117s@gmail.com";
  };
}
