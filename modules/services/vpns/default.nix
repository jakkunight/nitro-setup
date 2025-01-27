{ lib, config, ... }: {
  imports = [
    ./strongswan
  ];
  options = {
    serv.vpns = {
      enable = lib.mkEnableOption "Enable VPN services.";
    };
  };
  config = lib.mkIf config.serv.vpns {
    serv.vpns = {
      strongswan.enable = lib.mkDefault true;
    };
  };
}
