{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
    ../../users
  ];
  config = {
    # Enable Flakes!
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Allow unfree software:
    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

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

    # Set console settings:
    console = {
      # Setup console:
      enable = true;
      #earlySetup = true;

      # TTY font for my HiRes monitor:
      # packages = [
      #   pkgs.terminus_font
      # ];
      # font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";

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
        "4fd6be" # Green/Light green
        "ffc777" # Yellow/Orange
        "7aa2f7" # Blue/Light blue
        "bb9af7" # Magenta/Light magenta
        "b4f9f8" # Cyan/Light cyan
        "a9b1d6" # Gray/White
      ];
    };

    #### Module settings ####

    # Filesystems:
    disk = {
      filesystems = {
        boot.label = "BOOT";
        root.label = "root";
        swap.label = "linux-swap";
      };
    };

    # Bootloader:
    bootloader = {
      # Enable Systemd-Boot:
      systemd.enable = false;

      # Enable and config GRUB:
      grub = {
        enable = true;
        device.label = "nodev";
      };
    };
    audio = {
      enable = true;
      pipewire.enable = true;
    };
    terminal = {
      enable = true;
      filemanager = {
        enable = true;
        yazi.enable = true;
      };
      prompts = {
        enable = true;
        starship.enable = true;
      };
      multiplexer = {
        enable = true;
        zellij.enable = true;
      };
      editor = {
        enable = true;
        nvim = {
          enable = true;
          default = true;
          flavor = "nvf";
        };
        micro.enable = true;
      };
      shells = {
        enable = true;
        zsh = {
          enable = true;
          default = true;
        };
      };
      utils = {
        tui-journal.enable = true;
        wikitui.enable = true;
      };
    };
    net = {
      enable = true;
      strongswan.enable = true;
      tools = {
        enable = true;
      };
    };
    serv = {
      enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
      vpns = {
        enable = true;
        strongswan = {
          enable = true;
          connections = {
            enable = true;
            andescada.enable = true;
          };
        };
      };
    };
    graphics = {
      enable = true;
      nvidia.enable = true;
      fonts.enable = true;
      display-manager = {
        enable = true;
        sddm = {
          enable = true;
        };
      };
      wm = {
        enable = true;
        hyprland = {
          enable = true;
          nvidia.enable = true;
        };
      };
    };
    gaming = {
      enable = true;
      steam.enable = true;
    };
  };
}
