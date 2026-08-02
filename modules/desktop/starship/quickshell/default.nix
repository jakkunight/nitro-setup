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
        set -u

        # Cache the scan so repeated launcher invocations are instant. The scan
        # below is a pure-bash loop with a single jq pass, so even a cold (cache
        # miss) run completes in a few dozen milliseconds instead of spawning jq
        # once per application.
        CACHE_DIR="$HOME/.cache/starship-apps"
        if [ -n "$XDG_CACHE_HOME" ]; then CACHE_DIR="$XDG_CACHE_HOME/starship-apps"; fi
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
         if [ -n "$XDG_DATA_DIRS" ]; then
           while IFS= read -r d; do
             [ -n "$d" ] && dirs="$dirs:$d/applications"
           done < <(printf '%s\n' "$XDG_DATA_DIRS" | tr ':' '\n')
         fi

        tmp="$(${pkgs.coreutils}/bin/mktemp)"
        trap '${pkgs.coreutils}/bin/rm -f "$tmp"' EXIT

        old_ifs="$IFS"
        IFS=:
        for dir in $dirs; do
          [ -n "$dir" ] || continue
          [ -d "$dir" ] || continue
          for f in "$dir"/*.desktop; do
            [ -f "$f" ] || continue


            name=""
            generic=""
            icon=""
            type="Application"
            hidden=""
            nodisplay=""
            section=""
            while IFS= read -r line || [ -n "$line" ]; do
              [ -n "$line" ] || continue
              case "$line" in
                '#'*) continue ;;
              esac
              case "$line" in
                '['*']')
                  section="$line"
                  continue
                  ;;
              esac
              [ "$section" = "[Desktop Entry]" ] || continue
              IFS='=' read -r key rest <<< "$line"
              case "$key" in
                Name) name="$rest" ;;
                GenericName) generic="$rest" ;;
                Icon) icon="$rest" ;;
                Type) type="$rest" ;;
                NoDisplay) [ "$rest" = "true" ] && nodisplay=1 ;;
                Hidden) [ "$rest" = "true" ] && hidden=1 ;;
              esac
            done < "$f"

            [ "$type" = "Application" ] || continue
            [ -n "$name" ] || continue
            [ -z "$nodisplay" ] || continue
            [ -z "$hidden" ] || continue

            # Emit a tab-separated record. None of these fields ever contain a
            # TAB, so a single jq pass below builds the whole JSON array
            # without spawning jq once per application (the old bottleneck).
            # Duplicate app names are de-duplicated by jq (first occurrence
            # wins, so a user copy in an earlier dir beats a system copy).
            ${pkgs.coreutils}/bin/printf '%s\t%s\t%s\t%s\n' "$name" "$generic" "$icon" "$f" >> "$tmp"
          done
        done
        IFS="$old_ifs"

        ${pkgs.jq}/bin/jq -Rn \
          '[ inputs
             | split("\t")
             | select(length >= 4)
             | {name: .[0], generic: .[1], icon: .[2], path: .[3]} ]
          | reduce .[] as $x ({seen:{}, out:[]};
              ($x.name | ascii_downcase) as $k
              | if .seen[$k] then . else .seen[$k] = true | .out = (.out + [$x]) end)
          | .out' \
          "$tmp" | ${pkgs.coreutils}/bin/tee "$CACHE"
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
        var bluetoothctl = "${pkgs.bluez}/bin/bluetoothctl";
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
        bluez
        glib.bin
        libnotify
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
        "quickshell/components/NotificationPopup.qml".source = ./components/NotificationPopup.qml;
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
