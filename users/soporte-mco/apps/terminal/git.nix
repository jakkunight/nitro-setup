# Here goes my git credentials:
{ pkgs, lib, config, ... }@inputs:
{
  programs.git = {
    enable = true;
    userName = "Jakku Night";
    userEmail = "R101g117l117s@gmail.com";
  };

  # Use Gitui:
  programs.gitui = {
    enable = true;
  };
}
