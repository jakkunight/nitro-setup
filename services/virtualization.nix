# Here goes everything about my virtualisation config:
{ config, lib, pkgs, ... }@inputs:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager = {
    enable = true;
  };
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
