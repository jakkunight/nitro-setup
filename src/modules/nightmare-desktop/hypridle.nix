let
  moduleName = "nightmare-desktop";
in
  _: {
    flake.homeModules.${moduleName} = {pkgs, ...}: {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
          };
          listener = {
            timeout = 900;
            "on-timeout" = "${pkgs.hyprlock}/bin/hyprlock";
          };
        };
      };
    };
  }
