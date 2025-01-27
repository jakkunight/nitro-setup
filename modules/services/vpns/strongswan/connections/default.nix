{ lib, config, ... }: {
  imports = [
    ./andescada.nix
  ];
  options = {
    serv.vpns.strongswan.connections = {
      enable = lib.mkEnableOption "Enable the StrongSwan service.";
    };
  };
  config = lib.mkIf config.serv.vpns.strongswan.connections.enable {
    serv.vpns.strongswan.connections = {
      andescada.enable = lib.mkDefault true;
    };
  };
}

