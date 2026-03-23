let
  feature = "networking";
in
{
  flake.modules = {
    nixos.${feature} =
      { lib, ... }:
      {
        networking = {
          useDHCP = lib.mkDefault true;
          nameservers = lib.mkDefault [
            "1.1.1.1"
            "1.0.0.1"
          ];
          networkmanager = {
            enable = true; # Easiest to use and most distros use this by default.
            wifi = {
              powersave = true;
              macAddress = "permanent";
            };
            ethernet = {
              macAddress = "permanent";
            };
          };
        };
      };
  };
}
