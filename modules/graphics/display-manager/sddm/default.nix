# SDDM config:
{ lib, config, pkgs, inputs, ... }: {
  options = {
    graphics.display-manager.sddm = {
      enable = lib.mkEnableOption "Enable SDDM";
    };
  };
  config = lib.mkIf config.graphics.display-manager.sddm.enable {
    environment.systemPackages = with pkgs.libsForQt5.qt5; [
      qtdeclarative
      wrapQtAppsHook
      qtmultimedia
      qtquickcontrols
      qtgraphicaleffects
      pkgs.gst_all_1.gstreamer
      qtwayland
    ];
    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
      # theme = "${inputs.genshin-login.packages.${pkgs.system}.default}";
    };
  };
}
