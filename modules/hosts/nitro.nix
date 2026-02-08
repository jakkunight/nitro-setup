_: {
  nixosHosts.nitro = {
    system = "x86_64-linux";
    users = {
      jakku = let
        jakkuModules = [
          "hardware/disk/layouts/simple-no-swap"
          "hardware/disk/drivers"
          "hardware/disk/filesystems"
          "hardware/boot/grub/yorha-grub-theme"
          "hardware/cpu/intel"
          "hardware/gpu/nvidia"
          "hardware/kernel"
          "hardware/networking"
          "hardware/audio/pipewire"
          "hardware/bluetooth"
          "hardware/logitech"
          "hardware/printers"
          "installer"
          "development/devenv"
          "filemanager/yazi"
          "terminal/multiplexer/zellij"
          "terminal/prompt/starship"
          "terminal/shells/default"
          "terminal/shells/jakku"
          "terminal/system-monitor/btop"
          "terminal/utils/bat"
          "terminal/utils/eza"
          "terminal/utils/zoxide"
          "terminal/utils/widgets"
          "terminal/utils/nmap"
          "terminal/utils/coreutils"
          "text-editor/helix"
          "theming/stylix/nightmare"
          "music-player/mpd"
          "music-player/rmpc"
          "git"
          "nh"
          "nix"
          "time"
          "keyboard-layout"
          "system-state"
          "desktop/nightmare/sddm"
          "desktop/nightmare/hyprland"
          "desktop/nightmare/hyprland/nvidia"
          "desktop/nightmare/hyprwall"
          "desktop/nightmare/wofi"
          "desktop/nightmare/hyprlock"
          "desktop/nightmare/hypridle"
          "desktop/nightmare/waybar"
          "secrets/sops"
          "secrets/jakku"
          "virtualization"
          "applications/gaming"
          "applications/discord"
          "applications/zed-editor"
          "applications/finances"
          "applications/vlc"
          "applications/zen-browser"
          "applications/brave"
          "applications/nemo"
          "applications/kitty"
          "applications/gparted"
          "applications/ventoy"
          "applications/krita"
          "applications/obs-studio"
          "applications/obs-studio/nvidia"
          "applications/remmina"
          "applications/libreoffice"
          "applications/wireshark"
          "applications/zenmap"
        ];
      in {
        modules = jakkuModules;
        userConfig = {
          extraGroups = [
            "wheel"
            "networkmanager"
            "input"
            "libvirtd"
            "wireshark"
            "lpadmin"
          ];
        };
      };
    };
  };
}
