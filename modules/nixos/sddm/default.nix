{pkgs, ...}: {
  # SDDM:
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    enableHidpi = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
    theme = "${pkgs.sddm-astronaut.override {embeddedTheme = "japanese_aesthetic";}}/share/sddm/themes/sddm-astronaut-theme";
  };
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
  ];
}
