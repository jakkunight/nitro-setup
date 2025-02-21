{ lib, config, pkgs, ... }: {
  options = {
    serv.gvfs = {
      enable = lib.mkEnableOption "Enable GNOME Virtual FileSystem service.";
    };
  };
  config = lib.mkIf config.serv.gvfs.enable {
    services.gvfs.enable = true;
  };
}
