{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.gaming;
in {
  options = {
    modules.system.gaming = {
      enable = lib.mkEnableOption "Enable the gaming utils.";
    };
  };
  imports = [
    ./steam
    ./bottles
    ./heroic
    ./lutris
  ];
  config = lib.mkIf cfg.enable {
    # Enable OpenGL:
    hardware.graphics = {
      # Use this from NixOS 24.11+
      enable = true;
      enable32Bit = true;
    };

    # Extra gaming stuff:
    environment.systemPackages = [
      pkgs.mangohud
      pkgs.protonup-qt
    ];
  };
}
