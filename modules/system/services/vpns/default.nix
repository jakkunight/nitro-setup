{ lib, config, ... }: {
  imports = [
    ./strongswan
  ];
  options = {
    serv.vpns = {
      enable = lib.mkEnableOption "Enable VPN services.";
    };
  };
  config = lib.mkIf config.serv.vpns.enable {
    serv.vpns = {
      strongswan.enable = lib.mkDefault true;
    };
  };
}
