let
  hostname = "nitro";
in
  {
    inputs,
    self,
    ...
  }: {
    flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.${hostname}
        self.nixosModules.jakku
        self.nixosModules.core
        self.nixosModules.kanagawa-theme
        self.nixosModules.nightmare-desktop
        self.nixosModules.gaming
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
        inputs.disko.nixosModules.disko
        # Use Determinate Nix in this host:
        inputs.determinate.nixosModules.default
      ];

      # CPU:
      nixpkgs.hostPlatform.system = "x86_64-linux";
      hardware.cpu.intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
      boot.kernelModules = ["kvm-intel"];

      # Disk drivers:
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];

      # Disko config:
      disko.devices = {
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
          # Use the YoRHa theme:
          theme = lib.mkForce "${inputs.yorha-grub-theme.packages.${pkgs.stdenv.hostPlatform.system}.default}";
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

      # GPU:
      # Enable OpenGL:
      hardware.graphics = {
        # Use this from NixOS 24.11+
        enable = true;
        enable32Bit = true;
      };

      # Enable NVIDIA drivers:
      services.xserver.videoDrivers = [
        "nvidia"
      ];

      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        open = false;
        modesetting = {
          enable = true;
        };
        powerManagement = {
          enable = false;
          finegrained = false;
        };
        nvidiaSettings = true;
        prime = {
          # Sync mode will drain all your battery (default):
          sync.enable = true;

          # Offload will save some battery.
          #offload = {
          #  enable = true;
          #  enableOffloadCmd = true;
          #}

          # BusId is mandatory. It may be extracted from your machine:
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      # Define a special mode for using the offload mode:
      specialisation = {
        ON-THE-FLY.configuration = {
          system.nixos.tags = ["ON-THE-FLY"];
          hardware.nvidia = {
            prime.offload.enable = lib.mkForce true;
            prime.offload.enableOffloadCmd = lib.mkForce true;
            prime.sync.enable = lib.mkForce false;
          };
        };
      };

      # System State Version:
      system.stateVersion = "26.05";

      # Bootstrap the config to `/etc/nixos`
      system.copySystemConfiguration = false;
      environment.etc.nixos.source = ../../.;
      # system.includeBuildDependencies = true;

      # Timezone:
      time.timeZone = "America/Asuncion";

      # Locale:
      i18n.defaultLocale = "es_PY.UTF-8";
      services.xserver.enable = false;
      services.xserver.xkb.layout = "latam";
      services.libinput.enable = true;

      # Kernel Console:
      console = {
        font = "${pkgs.terminus_font}/share/consolefonts/ter-v24b.psf.gz";
        useXkbConfig = true; # use xkb.options in tty.
      };

      # System Theme:
    };
  }
