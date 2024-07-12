# Here goes my Hyprland setup:
{ config, lib, pkgs, ... }@inputs: {
  # Display Manager:
  services.displayManager.sddm = {
    enable = true;
    theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
  };

  # DConf:
  programs.dconf.enable = true;

  # Swaylock:
  environment.systemPackages = with pkgs; [
    dunst
    hypridle
    hyprcursor
    hyprnotify
    hyprpaper
    # Qt5:
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];

  programs.hyprland = {
    enable = true;
  };
}
