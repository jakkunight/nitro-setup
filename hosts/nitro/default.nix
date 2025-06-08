{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "nitro";

  # Local timezone:
  time.timeZone = "America/Asuncion";

  # Language and locale:
  i18n.defaultLocale = "es_PY.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "la-latin1";
    useXkbConfig = true;
  };

  # Some basic packages:
  environment.systemPackages = with pkgs; [
    micro # A simple text editor.
    git # Needed to use Flakes and clone repos.
  ];

  system.stateVersion = "25.05";
}
