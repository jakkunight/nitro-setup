# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/nixos
  ];

  # SOPS-NIX:
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/jakku/.config/sops/age/keys.txt";
    secrets = {
      "andescada/vpn_subnet_1" = {
        owner = "jakku";
      };
      "andescada/vpn_subnet_2" = {
        owner = "jakku";
      };
      "andescada/gateway_address" = {
        owner = "jakku";
      };
      "andescada/psk" = {
        owner = "jakku";
      };
      "andescada/username" = {
        owner = "jakku";
      };
      "andescada/password" = {
        owner = "jakku";
      };
    };
  };
  # INFO: To reference a secret:
  # - Use `sops.secrets."my-secret"` for plain secrets in secrets.yaml
  # - Use `sops.secrets."my/nested/secret"` for nested secrets in secrets.yaml
  #
  # Keys are stored in decripted form after rebuild in `/run/secrets` and
  # belong to the `root` user by default. To allow another user to access it without
  # `sudo` use:
  # ```nix
  # sops.secrets."my-secret" = {
  #   owner = config.users.users.${your_user}.name;
  # };
  # ```

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Asuncion";

  # ZRAM Swap:
  zramSwap = {
    enable = true;
  };

  # Bluetooth:
  hardware.bluetooth = {
    enable = true;
  };
  services.blueman.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_PY.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v24b.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkb.layout = "latam";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # services.pulseaudio.enable = true;
  # OR

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Shells:
  environment.shells = with pkgs; [
    zsh
  ];

  # Fonts:
  fonts.packages = [
    pkgs.nerd-fonts.hack
    inputs.genshin-font.packages.${pkgs.system}.default
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakku = {
    initialPassword = "1234";
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "libvirt"
      "input"
    ];
    packages = [
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    nh
    home-manager
    disko
    git
    zoxide
    eza
    sops
    dua
    remmina
    blocky
    clamav
    zellij
    tmux
    yazi
    gitui
    wineWowPackages.stable
    winetricks
    wineWayland
    heroic
    bottles-unwrapped
  ];

  # Steam:
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # ClamAV:
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # Blocky adblocker service:
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53; # Port for incoming DNS Queries.
      upstreams.groups.default = [
        "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];
      # For initially solving DoH/DoT Requests when no system Resolver is available.
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = ["1.1.1.1" "1.0.0.1"];
      };
      #Enable Blocking of certain domains.
      blocking = {
        denylists = {
          #Adblocking
          ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/adaway.org/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/adblock-nocoin-list/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/adguard-simplified/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/awavenue-ads/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/d3host/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/dandelionsprout-nordic/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ara/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-bul/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ces-slk/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-deu/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-fra/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-heb/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ind/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ita/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-kor/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-lav/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-lit/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-nld/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-pol/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-por/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-rus/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-spa/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-zho/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easyprivacy/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/eth-phishing-detect/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/gfrogeye-firstparty-trackers/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/hostsvn/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/kadhosts/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/matomo.org-spammers/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/mitchellkrogza-badd-boyz-hosts/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/pgl.yoyo.org/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/phishing.army/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/red.flag.domains/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/someonewhocares.org/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/spam404.com/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/stevenblack/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/turkish-ad-hosts/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2020/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2021/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2022/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2023/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2024/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2025/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-abuse/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-badware/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-privacy/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/urlhaus/list.txt"
          ];
          #Another filter for blocking adult sites
          adult = ["https://blocklistproject.github.io/Lists/porn.txt"];
          #You can add additional categories
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = ["ads"];
          # kids-ipad = ["ads" "adult"];
        };
      };
    };
  };

  # UWSM:
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };

  programs.starship = {
    enable = true;
  };

  # SDDM:
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
  };

  # Hyprland:
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };

  hardware.graphics = {
    package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa;
    enable32Bit = true;
  };

  # Trash (GNOME Virtual FileSystem):
  services.gvfs.enable = true;

  # Automount USB drives:
  services.udisks2.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
