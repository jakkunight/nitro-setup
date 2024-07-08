# Here goes my git credentials:
{ config, pkgs, ... }@inputs:
{
  programs.git = {
    enable = true;
    user = {
      name = "Jakku Night";
      email = "R101g117l117s@gmail.com";
    };
  };
}
