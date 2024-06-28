# User management:
{ config, lib, pkgs, ... }@inputs: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakku = {
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      firefox-wayland
      tree
      libreoffice
    ];
  };
}
