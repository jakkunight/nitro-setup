{
  inputs,
  config,
  lib,
  ...
}: {
  nixosHosts.nitro = {
    system = "x86_64-linux";
    users = {
      jakku = let
        jakkuModules = [
          "hardware/disk/layouts/simple-no-swap"
          "hardware/disk/drivers"
          "hardware/disk/filesystems"
          "hardware/boot/grub/wanderer-themes"
          "hardware/cpu/intel"
          "hardware/cpu/scheduler"
          "hardware/gpu/nvidia"
          "hardware/kernel"
          "hardware/networking"
          "hardware/audio/pipewire"
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
          "desktop/nightmare/hyprland"
          "desktop/nightmare/hypridle"
          "desktop/nightmare/hyprpaper"
          "desktop/nightmare/sddm"
          "desktop/nightmare/waybar"
          "desktop/nightmare/wofi"
          "desktop/nightmare/hyprlock"
          "secrets/sops"
          "secrets/jakku"
          "applications/gaming"
          "applications/discord"
          "applications/zed-editor"
          "applications/finances"
          "applications/vlc"
          "applications/zen-browser"
          "applications/nemo"
          "applications/kitty"
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
          ];
        };
      };
    };
  };
}
