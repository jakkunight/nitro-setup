{
  pkgs,
  config,
  ...
}: {
  # SDDM:
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    enableHidpi = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
    theme = "${pkgs.sddm-astronaut.override {embeddedTheme = "hyprland_kath";}}/share/sddm/themes/sddm-astronaut-theme";
    settings = {
      Theme = {
        CursorTheme = "LyraB-cursors";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
  ];
}
