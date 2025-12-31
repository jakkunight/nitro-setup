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
    };
    homeManager.${moduleName} = _: {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      # configure options
      programs.noctalia-shell = {
        enable = true;
        settings = {
          # configure noctalia here
          bar = {
            density = "compact";
            position = "right";
            showCapsule = false;
            widgets = {
              left = [
                {
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
                {
                  id = "WiFi";
                }
                {
                  id = "Bluetooth";
                }
              ];
              center = [
                {
                  hideUnoccupied = false;
                  id = "Workspace";
                  labelMode = "none";
                }
              ];
              right = [
                {
                  alwaysShowPercentage = false;
                  id = "Battery";
                  warningThreshold = 30;
                }
                {
                  formatHorizontal = "HH:mm";
                  formatVertical = "HH mm";
                  id = "Clock";
                  useMonospacedFont = true;
                  usePrimaryColor = true;
                }
              ];
            };
          };
          colorSchemes.predefinedScheme = "Monochrome";
          general = {
            avatarImage = "/home/drfoobar/.face";
            radiusRatio = 0.2;
          };
          location = {
            monthBeforeDay = true;
            name = "Marseille, France";
          };
        };
        # this may also be a string or a path to a JSON file,
        # but in this case must include *all* settings.
      };
    };
  };
}
