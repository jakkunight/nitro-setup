{ lib, config, pkgs, ... }: {
  options = {
    serv.udisks2 = {
      enable = lib.mkEnableOption "Enable udisks2 service.";
    };
  };
  config = lib.mkIf config.serv.udisks2.enable {
    services.udisks2 = {
      enable = true;
      mountOnMedia = true;
      settings = {};
    };
  };
}
