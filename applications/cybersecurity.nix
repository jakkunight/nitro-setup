# Cybersecurity tools.
# Use them wisely.
{ pkgs, config, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    wireshark
    nmap
    hydra-cli
    thc-hydra
    hashcat
    hashcat-utils
    hcxtools
    macchanger
    aircrack-ng
    john
    crackmapexec
    responder
  ];


}
