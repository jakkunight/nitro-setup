{inputs, ...}: let
  moduleName = "desktop/noctalia";
in {
  flake.modules = {
    nixos.${moduleName} = {
      pkgs,
      lib,
      ...
    }: {
      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      networking.networkmanager.enable = lib.mkForce true;
      hardware.bluetooth.enable = lib.mkForce true;
      services.power-profiles-daemon.enable = lib.mkForce true;
      services.upower.enable = lib.mkForce true;

      # services.noctalia-shell = {
      #   enable = true;
      #   target = "my-hyprland-session.target";
      # };
    };
    homeManager.${moduleName} = {config, ...}: {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      # configure options
      programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;
        settings = {
          # configure noctalia here
          bar = {
            density = "default";
            position = "top";
            showCapsule = false;
            showOutline = false;
            floating = true;
            wallpaper = {
              enable = true;
              fillMode = "center";
            };
            widgets = {
              left = [
                {
                  icon = "nix";
                  id = "CustomButton";
                  leftClickExec = "qs -c noctalia-shell ipc call launcher toggle";
                }
                {
                  id = "Clock";
                  usePrimaryColor = false;
                }
                {
                  id = "SystemMonitor";
                }
                {
                  id = "ActiveWindow";
                }
                {
                  id = "MediaMini";
                }
              ];
              center = [
                {
                  id = "Workspace";
                }
              ];
              right = [
                {
                  id = "ScreenRecorder";
                }
                {
                  id = "Tray";
                }
                {
                  id = "NotificationHistory";
                }
                {
                  id = "Battery";
                }
                {
                  id = "Volume";
                }
                {
                  id = "Brightness";
                }
                {
                  id = "ControlCenter";
                }
              ];
            };
          };
          general = {
            avatarImage = "${config.home.homeDirectory}/.face";
            radiusRatio = 0.2;
            lockOnSuspend = true;
            showSessionButtonsOnLockScreen = true;
            showHibernateOnLockScreen = false;
          };
          location = {
            monthBeforeDay = false;
            name = "Asuncion, Paraguay";
          };
        };
        # this may also be a string or a path to a JSON file,
        # but in this case must include *all* settings.
      };
    };
  };
}
