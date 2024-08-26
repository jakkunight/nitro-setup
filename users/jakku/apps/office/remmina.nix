{ pkgs, lib, config, ... }@inputs:
{
  services.remmina = {
    enable = true;
    systemdService.enable = true;
  };
}
