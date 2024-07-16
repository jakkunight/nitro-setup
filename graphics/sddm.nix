# SDDM config:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Qt5:
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "${import ./../assets/sddm-theme.nix { inherit pkgs; }}";
  };
}
