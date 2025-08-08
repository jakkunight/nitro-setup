{pkgs, ...}: {
  # SDDM:
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
    theme = "${pkgs.sddm-astronaut.override {embeddedTheme = "japanese_aesthetic";}}/share/sddm/themes/sddm-astronaut-theme";
  };
}
