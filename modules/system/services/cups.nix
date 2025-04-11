{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    serv.cups = {
      enable = lib.mkEnableOption "Enable CUPS service.";
    };
  };
  config = {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      printing = {
        enable = true;
        drivers = with pkgs; [gutenprint hplip splix];
        cups-pdf = {
          enable = true;
        };
      };
    };
  };
}
