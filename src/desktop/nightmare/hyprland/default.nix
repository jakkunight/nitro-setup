let
  feature = "nightmare-hyprland";
in
{
  self,
  inputs,
  ...
}:
{
  flake.modules.homeManager.${feature} =
    { pkgs, lib, ... }:
    {
      imports = with self.modules.homeManager; [
        hyprland
        # kitty
        # foot
        # zen-browser
        # waybar
        # hyprwall
        # swaync
        # ashell
        # hyprlock
        # hypridle
        # zsh
        # nushell
        # qutebrowser
        # remmina
        # wofi
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        settings = {
          config = {
            general = {
              # master layout for now:
              layout = "master";
              border_size = 2;
              gaps_in = 0;
              gaps_out = 0;
              gaps_workspaces = 0;
              float_gaps = 0;
            };
          };
        };
      };

    };
}
