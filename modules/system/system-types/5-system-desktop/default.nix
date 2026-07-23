{ self, inputs, ... }:
{
  flake.modules.nixos."5-system-desktop" = {
    imports = with self.modules.nixos; [
      "4-system-cli"
      stylix
      nightmare-desktop
    ];
  };
  flake.modules.homeManager."5-system-desktop" = {
    imports = with self.modules.homeManager; [
      "4-system-cli"
      nightmare-desktop
      nightmare-hyprland
      nightmare-waybar
      hyprlock
      hypridle
      hyprwall
      swaync
      wofi
    ];
  };
}
