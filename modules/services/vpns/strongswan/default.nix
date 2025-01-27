{ lib, config, ... }: {
  imports = [
    ./connections
  ];
  options = {
    serv.vpns.strongswan = {
      enable = lib.mkEnableOption "Enable the StrongSwan service.";
    };
  };
  config = lib.mkIf config.serv.vpns.strongswan.enable {
    serv.vpns.strongswan = {
      connections.enable = lib.mkDefault true;
    };
  };
}
