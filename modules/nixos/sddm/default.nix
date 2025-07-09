_: {
  # SDDM:
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
  };
}
