{ lib, config, pkgs, ... }: {
  options = {
    net.tools.wireshark = {
      enable = lib.mkEnableOption "Enable Wireshark.";
    };
  };
  config = lib.mkIf config.net.tools.wireshark.enable {
    environment.systemPackages = [
      pkgs.nmap
    ];
  };
}

