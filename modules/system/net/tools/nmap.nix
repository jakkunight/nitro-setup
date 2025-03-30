{ lib, config, pkgs, ... }: {
  options = {
    net.tools.nmap = {
      enable = lib.mkEnableOption "Enable nmap.";
    };
  };
  config = lib.mkIf config.net.tools.nmap.enable {
    environment.systemPackages = [
      pkgs.nmap
    ];
  };
}
