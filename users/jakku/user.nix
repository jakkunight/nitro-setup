# Users config:
{ pkgs, config, lib, inputs, ... }:
{
  # Use ZSH as default shell:
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.jakku.useDefaultShell = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakku = {
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.

    # User packages:
    packages = with pkgs; [
      firefox
      libreoffice
      brave
      discord
      remmina
      audacity
      kdePackages.kdenlive
      obs-studio
      alacritty
      xfce.thunar
      vlc
      wofi
    ];
  };

}
