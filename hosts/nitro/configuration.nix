{ lib, config, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];
  config = {
    # Enable Flakes!
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Allow unfree software:
    nixpkgs.config.allowUnfree = true;

    # State Version:
    system.stateVersion = "25.05";

    # Hostname:
    networking.hostName = "nitro";

    # Timezone:
    time.timeZone = "America/Asuncion";

    # Set Keyboard layout:
    services.xserver.xkb.layout = "latam";

    # Select internationalisation properties.
    i18n.defaultLocale = "es_PY.UTF-8";

    # Set console font:
    console = {
      # TTY font for my HiRes monitor:
      font = "Terminus 32 bold";

      # Keymap:
      #keyMap = "latam";

      # Use XKB options on TTY:
      useXkbConfig = true; # use xkb.options in tty.
      
      # TokyoNight palette for TTY:
      colors = [
        "1f2335" # Black/Dark gray
        "c53b53" # Red/Light red
        "41a6b5" # Green/Light green
        "ff9e64" # Yellow/Orange
        "3d59a1" # Blue/Light blue
        "9d7cd8" # Magenta/Light magenta
        "7dcfff" # Cyan/Light cyan
        "737aa2" # Gray/White

        "545c7e" # Black/Dark gray
        "ff757f" # Red/Light red
        "ffc777" # Green/Light green
        "ff9e64" # Yellow/Orange
        "7aa2f7" # Blue/Light blue
        "bb9af7" # Magenta/Light magenta
        "b4f9f8" # Cyan/Light cyan
        "a9b1d6" # Gray/White
      ];
    };
  };

  #### Module settings ####
  
  # Filesystems:
  config.disk = {
    filesystems = {
      boot.label = "ESP";
      root.label = "root";
    };
  };

  # Bootloader:
  config.bootloader = {
    # Disable Systemd-Boot:
    systemd.enable = false;

    # Enable and config GRUB:
    grub = {
      enable = true;
      device.label = "ESP";
    };
  };
}
