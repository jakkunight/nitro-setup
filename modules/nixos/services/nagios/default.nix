{
  config,
  pkgs,
  ...
}: {
  services = {
    nagios = {
      enable = true;
      enableWebInterface = true;
      objectDefs = [
        ./localhost.cfg
        ./templates.cfg
        ./timeperiods.cfg
        ./commands.cfg
        ./contacts.cfg
      ];
      virtualHost = {
        hostName = "local.nagios.net";
        locations = {
          "/" = {
            proxyPass = "http://localhost:8080";
            index = "index.php index.html";
          };
        };
        listen = {
          "local.nagios.net" = {
            ip = "127.0.0.1";
            port = "8080";
            ssl = false;
          };
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    8080
    5666
  ];
}
