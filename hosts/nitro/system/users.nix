# User management:
{ config, lib, pkgs, ... }@inputs: {
  # Allow unfree software:
  nixpkgs.config.allowUnfree = true;

  # Use ZSH as default shell:
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.jakku.useDefaultShell = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakku = {
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox-wayland
      tree
      libreoffice
      brave
      discord
      steam
      udiskie
      remmina
      xfce.thunar
      xfce.thunar-volman
      gnome.gvfs
      gnome.gdm
    ];
  };

  # Thunar config:
  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
