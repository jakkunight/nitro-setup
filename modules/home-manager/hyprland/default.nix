_: {
  imports = [
    ./keybinds.nix
    ./decorations.nix
    ./monitors.nix
    ./layouts.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    # Use the flake package:
    package = null;
    portalPackage = null;
    # plugins = [
    #   inputs.hy3.packages.x86_64-linux.hy3
    # ];
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      input = {
        kb_layout = "latam";
        follow_mouse = 1;
      };
      exec-once = [
        "uwsm app -- systemctl --user start waybar.service"
        # "${pkgs.uwsm}/bin/uwsm app -- ${inputs.quickshell.packages.${pkgs.system}.default}/bin/quickshell"
        # "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.quickshell}/bin/quickshell"
      ];

      # Cursor:
      cursor = {
        no_hardware_cursors = true;
      };
      # Gestures:
      gestures = {
        workspace = true;
      };
      # hy3 = {
      # };
      windowrulev2 = [
        # "center, floating:1"
      ];

      # Misc:
      misc = {
        vfr = true;
      };
    };
  };

  services = {
    hyprpolkitagent = {
      enable = true;
    };
  };
}
