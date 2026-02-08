{inputs, ...}: {
  flake.modules.homeManager."desktop/nightmare/hyprwall" = {
    pkgs,
    lib,
    ...
  }: let
    wallpapers = [
      ./wallpapers/default.jpg
      ./wallpapers/Scaramouche-Wallpaper-4k.jpg
      ./wallpapers/wanderer-sakura-wallpaper.jpg
      ./wallpapers/wanderer-wallpaper.jpeg
      ./wallpapers/Scaramouche-wallpaper.jpg
      ./wallpapers/main-wallpaper.jpg
    ];
    hyprwall = pkgs.writeShellApplication {
      name = "hyprwall.sh";
      runtimeInputs = with pkgs; [
        socat
        uutils-coreutils-noprefix
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
      ];
      bashOptions = [];
      text = ''
        SERVICE_NAME="your-service"
        PID_FILE="/var/run/''${SERVICE_NAME}.pid"
        handle() {
          case $1 in
            workspace*)
              local WALLPAPERS=(${builtins.concatStringsSep " " (map (x: toString x) wallpapers)})
              local MIN=0
              local MAX=${toString (builtins.length wallpapers - 1)}
              local RAND
              RAND=$(shuf -n 1 -i $MIN-$MAX)
              awww img --transition-type any --transition-fps 30 --transition-step 90 --transition-duration 1 "''${WALLPAPERS[RAND]}"
            ;;
          esac
        }
        echo "[INFO] Starting Hyprwall service..."
        echo "[INFO] Killing Hyprpaper service..."
        systemctl --user stop hyprpaper.service
        if [ -f "$PID_FILE" ]; then
          if kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
            echo -e "[WARN] Service is already running"
            return 1
          else
            echo -e "[WARN] Removing stale PID file"
            rm -f "$PID_FILE"
          fi
        fi
        echo "[INFO] Running AWWW daemon..."
        awww-daemon &
        echo "[INFO] AWWW daemon is running."
        echo "[INFO] Listening Hyprland IPC socket for events..."
        socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
      '';
    };
  in {
    home.packages = [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
      hyprwall
    ];

    # Create a Systemd unit for the service
    systemd.user.services = {
      hyprwall = {
        Unit = {
          Description = "Hyprwall. A daemon to dynamicly change wallpapers with AWWW and Wayland (for Hyprland).";
          X-SwitchMethod = "restart";
        };
        Service = {
          ExecStart = "${lib.getExe hyprwall}";
        };
      };
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "systemctl --user enable --now hyprwall || ${lib.getExe hyprwall} &"
      ];
    };
  };
}
