let
  hostname = "sophie";
in
  {
    inputs,
    self,
    lib,
    ...
  }: {
    flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.${hostname}
      ];
    };

    flake.nixosModules.${hostname} = {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }: {
      # Extra drivers:
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        inputs.milk-grub-theme.nixosModule
        inputs.disko.nixosModules.disko
      ];

      # CPU:
      nixpkgs.hostPlatform.system = "x86_64-linux";
      hardware.cpu.intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
      boot.kernelModules = ["kvm-intel"];

      # Disko configuration:
      disko = {
        enableConfig = lib.mkForce true;
        devices = {
          disk.${hostname} = {
            device = "/dev/sda";
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  type = "EF00";
                  size = "1G";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = ["umask=0077"];
                  };
                };
                root = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };

      # Disk drivers:
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];

      # Bootloader:
      # NOTE:
      # These services are disabled, since they add A LOT of time to the
      # boot process and almos everything that has something to do with the
      # disk/networking/kernel.
      hardware.bluetooth.powerOnBoot = lib.mkForce false;
      systemd.services = {
        systemd-udev-settle.enable = false;
        NetworkManager-wait-online.enable = false;
      };
      boot.loader = {
        efi = {
          canTouchEfiVariables = true;
        };
        systemd-boot = {
          enable = false;
        };
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
          efiInstallAsRemovable = false;
          # Use the MilkGRUB Theme:
          gfxmodeEfi = "1920x1080"; # set your resolution
          gfxpayloadEfi = "keep";
          milk-theme.enable = true;
        };
      };

      # Kernel version:
      # Use a custom kernel:
      boot.kernel.enable = true;
      # Allow unfree drivers:
      nixpkgs.config.allowUnfree = true;
      # Use latest kernel (ZEN).
      boot.kernelPackages = pkgs.linuxPackages_zen;
      # Enable SysRq:
      boot.kernel.sysctl."kernel.sysrq" = 1;
      # Firmware/BIOS updates:
      services.fwupd.enable = true;

      # Audio:
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        audio.enable = true;
        wireplumber = {
          enable = true;
          package = pkgs.wireplumber;
        };
        pulse.enable = true;
        jack.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
      };

      # Networking:
      networking.useDHCP = lib.mkDefault true;
      networking.hostName = "${hostname}"; # Define your hostname.
      # Pick only one of the below networking options.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      networking.nameservers = lib.mkDefault [
        "1.1.1.1"
        "1.0.0.1"
      ];
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

      # Bluetooth:
      hardware.bluetooth = {
        enable = true;
      };
      services.blueman.enable = true;
      environment.systemPackages = with pkgs; [
        blueberry
      ];

      # Enable OpenGL:
      hardware.graphics = {
        # Use this from NixOS 24.11+
        enable = true;
        enable32Bit = true;
      };

      # System State Version:
      system.stateVersion = "26.05";

      # Bootstrap the config to `/etc/nixos`
      system.copySystemConfiguration = false;
      environment.etc.nixos.source = ../../.;
    };
  }
