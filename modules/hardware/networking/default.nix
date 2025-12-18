{inputs, ...}: {
  flake.modules.nixos."hardware/networking" = {
    pkgs,
    lib,
    ...
  }: {
    networking.useDHCP = lib.mkDefault true;
    networking.hostName = "nitro"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
      wifi = {
        powersave = true;
        macAddress = "random";
      };
      ethernet = {
        macAddress = "random";
      };
    };
  };
}
