# Networking config and modules:
{
  lib,
  config,
  ...
}: {
  imports = [
    ./wireshark.nix
    ./nmap.nix
    ./hblock.nix
  ];
  options = {
    net.tools = {
      enable = lib.mkEnableOption "Enable common networking tools.";
    };
  };
  config = lib.mkIf config.net.tools.enable {
    net.tools = {
      nmap.enable = lib.mkDefault true;
      wireshark.enable = lib.mkDefault true;
      hblock.enable = lib.mkDefault true;
    };
  };
}
