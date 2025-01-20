# X11 config:
{ pkgs, config, lib, inputs, ... }:
{
  # Enable X11:
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
  };

  # Xclip:
  environment.systemPackages = with pkgs; [
    xclip
  ];
}
