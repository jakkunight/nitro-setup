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
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ]; # Enable ‘sudo’ for the user.

    # User packages:
    packages = with pkgs; [
      firefox
      libreoffice
      brave
      discord
      remmina
      audacity
      libsForQt5.kdenlive
      obs-studio
      alacritty
      xfce.thunar
      vlc
      wofi
      tokyonight-gtk-theme
      gimp
      inkscape
      krita
      zathura
      loupe
      moodle
      moodle-dl
      freetube
      flatpak
      ffmpeg
      flatpak-builder
      teams-for-linux
      thunderbird
      rnote
      waydroid
      weylus
      pandoc
      texliveFull
      mpvpaper
    ];
  };

  # Add them to the Nix store trusted users:
  nix.settings.trusted-users = [
    "jakku"
    "root"
    "@wheel"
  ];

  # Fix Firefox bug:
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 0;
  };

  # Weylus ports:
  networking.firewall.allowedTCPPorts = [
    1701
    9001
  ];
}
