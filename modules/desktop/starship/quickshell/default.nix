let
  feature = "starship-quickshell";
in
{
  self,
  inputs,
  ...
}:
{
  flake.modules.homeManager.${feature} =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      # Reads CPU/mem/disk/network/temperature and emits JSON for the HUD.
      starshipStats = pkgs.writeShellScriptBin "starship-stats" ''
        # shellcheck disable=SC1091
        set -u

        sample_cpu() {
          awk '/^cpu /{total=0; for(i=2;i<=NF;i++) total+=$i; idle=$5; print total, idle}' /proc/stat
        }

        sample_net() {
          awk 'NR>2 {
            if ($1 ~ /:$/) {
              gsub(":", "", $1)
              if ($1 != "lo") { rx += $2; tx += $10 }
            }
          } END { print rx, tx }' /proc/net/dev
        }

        read -r C1_TOTAL C1_IDLE < <(sample_cpu)
        read -r N1_RX N1_TX < <(sample_net)
        sleep 1
        read -r C2_TOTAL C2_IDLE < <(sample_cpu)
        read -r N2_RX N2_TX < <(sample_net)

        # CPU percent over the sample window
        CPU_DT=$(( C2_TOTAL - C1_TOTAL ))
        CPU_IDLE_DT=$(( C2_IDLE - C1_IDLE ))
        CPU=0
        if [ "$CPU_DT" -gt 0 ]; then
          CPU=$(( (CPU_DT - CPU_IDLE_DT) * 100 / CPU_DT ))
        fi

        # Memory percent + absolute usage (KiB; /proc/meminfo reports KiB)
        read -r MEM_TOTAL < <(awk '/^MemTotal:/{print $2}' /proc/meminfo)
        read -r MEM_AVAIL < <(awk '/^MemAvailable:/{print $2}' /proc/meminfo)
        MEM=0
        MEM_USED=0
        if [ "$MEM_TOTAL" -gt 0 ]; then
          MEM_USED=$(( MEM_TOTAL - MEM_AVAIL ))
          [ "$MEM_USED" -lt 0 ] && MEM_USED=0
          MEM=$(( MEM_USED * 100 / MEM_TOTAL ))
        fi

        # Root filesystem usage (df -Pk reports 1024-byte blocks, i.e. KiB)
        read -r DISK_TOTAL DISK_USED DISK < <(${pkgs.coreutils}/bin/df -Pk / | awk 'NR==2 {gsub("%","",$5); print $2, $3, $5}')
        DISK=''${DISK:-0}
        DISK_TOTAL=''${DISK_TOTAL:-0}
        DISK_USED=''${DISK_USED:-0}

        # Network rate in KB/s
        NET_RX=$(( (N2_RX - N1_RX) / 1024 ))
        NET_TX=$(( (N2_TX - N1_TX) / 1024 ))
        [ "$NET_RX" -lt 0 ] && NET_RX=0
        [ "$NET_TX" -lt 0 ] && NET_TX=0

        # Temperature (millidegrees -> degrees)
        TEMP=0
        if [ -r /sys/class/thermal/thermal_zone0/temp ]; then
          TEMP=$(( $(cat /sys/class/thermal/thermal_zone0/temp) / 1000 ))
        fi

        ${pkgs.jq}/bin/jq -nc \
          --arg cpu "$CPU" \
          --arg mem "$MEM" \
          --arg memused "$MEM_USED" \
          --arg memtotal "$MEM_TOTAL" \
          --arg disk "$DISK" \
          --arg diskused "$DISK_USED" \
          --arg disktotal "$DISK_TOTAL" \
          --arg netrx "$NET_RX" \
          --arg nettx "$NET_TX" \
          --arg temp "$TEMP" \
          '{cpu: $cpu, mem: $mem, memused: $memused, memtotal: $memtotal, disk: $disk, diskused: $diskused, disktotal: $disktotal, netrx: $netrx, nettx: $nettx, temp: $temp}'
      '';

      # Scans the desktop application dirs for *.desktop entries and emits a
      # JSON array [{name, generic, icon, path}] for the app launcher. User
      # dirs come first so a duplicate basename prefers the user's copy.
      starshipApps = pkgs.writeShellScriptBin "starship-apps" ''
        # shellcheck disable=SC1091

        # Cache the scan for an hour so repeated launcher invocations are instant.
        CACHE_DIR="/tmp/starship-apps"
        CACHE="$CACHE_DIR/apps.json"
        ${pkgs.coreutils}/bin/mkdir -p "$CACHE_DIR"
        if [ -f "$CACHE" ]; then
          now="$(${pkgs.coreutils}/bin/date +%s)"
          age="$(( now - $(${pkgs.coreutils}/bin/stat -c %Y "$CACHE") ))"
          if [ "$age" -lt 3600 ]; then
            ${pkgs.coreutils}/bin/cat "$CACHE"
            exit 0
          fi
        fi

        dirs="$HOME/.local/share/applications"
        for d in "$HOME/.nix-profile/share" "/run/current-system/sw/share"; do
          dirs="$dirs:$d/applications"
        done
        while IFS= read -r d; do
          [ -n "$d" ] && dirs="$dirs:$d/applications"
        done < <(echo "$XDG_DATA_DIRS" | ${pkgs.coreutils}/bin/tr ':' '\n')

        tmp="$(${pkgs.coreutils}/bin/mktemp)"
        trap '${pkgs.coreutils}/bin/rm -f "$tmp"' EXIT

        seen=""
        seen_names=""
        old_ifs="$IFS"
        IFS=:
        for dir in $dirs; do
          [ -n "$dir" ] || continue
          [ -d "$dir" ] || continue
          for f in "$dir"/*.desktop; do
            [ -f "$f" ] || continue
            base="$(${pkgs.coreutils}/bin/basename "$f")"
            case " $seen " in *" $base "*) continue ;; esac
            seen="$seen $base"

            name=""
            generic=""
            icon=""
            type="Application"
            hidden=""
            nodisplay=""
            section=""
            while IFS= read -r line || [ -n "$line" ]; do
              line="$(${pkgs.coreutils}/bin/tr -d '\r' <<< "$line")"
              [ -n "$line" ] || continue
              case "$line" in
                '#'*) continue ;;
              esac
              case "$line" in
                '['*']')
                  section="$(${pkgs.coreutils}/bin/tr -d '[]' <<< "$line")"
                  continue
                  ;;
              esac
              [ "$section" = "Desktop Entry" ] || continue
              case "$line" in
                'Name='*) name="$(${pkgs.coreutils}/bin/cut -d= -f2- <<< "$line")" ;;
                'GenericName='*) generic="$(${pkgs.coreutils}/bin/cut -d= -f2- <<< "$line")" ;;
                'Icon='*) icon="$(${pkgs.coreutils}/bin/cut -d= -f2- <<< "$line")" ;;
                'Type='*) type="$(${pkgs.coreutils}/bin/cut -d= -f2- <<< "$line")" ;;
                'NoDisplay=true'*) nodisplay=1 ;;
                'Hidden=true'*) hidden=1 ;;
              esac
            done < "$f"

            [ "$type" = "Application" ] || continue
            [ -n "$name" ] || continue
            [ -z "$nodisplay" ] || continue
            [ -z "$hidden" ] || continue

            # One entry per app name (e.g. kdenlive.desktop vs
            # org.kde.kdenlive.desktop both claim "Kdenlive").
            lc_name="$(${pkgs.coreutils}/bin/tr 'A-Z' 'a-z' <<< "$name")"
            case " $seen_names " in *" $lc_name "*) continue ;; esac
            seen_names="$seen_names $lc_name"

            ${pkgs.jq}/bin/jq -nc \
              --arg name "$name" \
              --arg generic "$generic" \
              --arg icon "$icon" \
              --arg path "$f" \
              '{name: $name, generic: $generic, icon: $icon, path: $path}' >> "$tmp"
          done
        done
        IFS="$old_ifs"

        ${pkgs.jq}/bin/jq -s '.' "$tmp" | ${pkgs.coreutils}/bin/tee "$CACHE" > /dev/null
        ${pkgs.coreutils}/bin/cat "$CACHE"
      '';

      # A JS palette file that the QML can import (import "colors.js" as Colors).
      colorsJs =
        let
          inherit (config.lib.stylix.colors.withHashtag)
            base00
            base01
            base02
            base03
            base04
            base05
            base06
            base07
            base08
            base09
            base0A
            base0B
            base0C
            base0D
            base0E
            base0F
            ;
        in
        ''
          // Generated from the active Stylix base16 scheme.
          var base00 = "${base00}";
          var base01 = "${base01}";
          var base02 = "${base02}";
          var base03 = "${base03}";
          var base04 = "${base04}";
          var base05 = "${base05}";
          var base06 = "${base06}";
          var base07 = "${base07}";
          var base08 = "${base08}";
          var base09 = "${base09}";
          var base0A = "${base0A}";
          var base0B = "${base0B}";
          var base0C = "${base0C}";
          var base0D = "${base0D}";
          var base0E = "${base0E}";
          var base0F = "${base0F}";
          var fontFamily = "${config.stylix.fonts.monospace.name}";
        '';

      # Paths to the tools used by the QML, as a JS module.
      pathsJs = ''
        // Generated by the starship-quickshell module.
        // hyprctl must point at the exact flake package that is actually
        // installed system-wide (modules/desktop/hyprland.nix), not the
        // unrelated nixpkgs build which may not be present at runtime.
        var hyprctl = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl";
        var wpctl = "${pkgs.wireplumber}/bin/wpctl";
        var brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        var stats = "${starshipStats}/bin/starship-stats";
        var face = "${config.home.homeDirectory}/.face";
        var userName = "${config.home.username}";
        var apps = "${starshipApps}/bin/starship-apps";
        var gio = "${pkgs.glib.bin}/bin/gio";
      '';
    in
    {
      home.packages = with pkgs; [
        quickshell
        brightnessctl
        wireplumber
        glib.bin
        starshipStats
        starshipApps
      ];

      xdg.configFile = {
        "quickshell/shell.qml".source = ./shell.qml;
        "quickshell/launcher.qml".source = ./launcher.qml;
        "quickshell/colors.js".text = colorsJs;
        "quickshell/paths.js".text = pathsJs;
        "quickshell/components/WorkspaceButton.qml".source = ./components/WorkspaceButton.qml;
        "quickshell/components/StatBlock.qml".source = ./components/StatBlock.qml;
        "quickshell/components/HudSlider.qml".source = ./components/HudSlider.qml;
        "quickshell/components/UserBadge.qml".source = ./components/UserBadge.qml;
      };

      systemd.user.services.quickshell = {
        Unit = {
          Description = "Starship Holographic HUD (Quickshell)";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.quickshell}/bin/quickshell -p ${config.xdg.configHome}/quickshell";
          Restart = "on-failure";
          RestartSec = 2;
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
