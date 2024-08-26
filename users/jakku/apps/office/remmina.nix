{ pkgs, lib, config, ... }@inputs:
{
  programs.remmina = {
    enable = true;
    systemdService.enable = true;
  };
}
