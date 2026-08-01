let
  feature = "starship-desktop";
in
{
  self,
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.${feature} =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = with self.modules.nixos; [
          hyprland
          hyprland-nvidia
          kitty
          foot
          ghostty
          starship-theme
        ];

      };
    homeManager.${feature} =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports = with self.modules.homeManager; [
          starship-hyprland
          starship-quickshell
          kitty
          foot
          ghostty
          zen-browser
          hyprwall
          swaync
          # ashell
          hyprlock
          hypridle
          zsh
          wofi
          starship-theme
        ];

        programs.zsh.initContent = lib.mkOrder 1200 ''
          clear
          ${pkgs.fastfetch}/bin/fastfetch
          echo "All systems nominal, $USER. (^.^)"
        '';

        programs.kitty = {
          font.package = lib.mkForce config.stylix.fonts.monospace.package;
          font.name = lib.mkForce "family=\"${config.stylix.fonts.monospace.name}\"";
        };

        # Display the Stylix wallpaper through Hyprpaper (provides hyprpaper.service).
        services.hyprpaper = {
          enable = true;
          settings = {
            preload = [ "${config.stylix.image}" ];
            wallpaper = [ ",${config.stylix.image}" ];
          };
        };

        programs.wofi = {
          settings = {
            allow_images = true;
          };
        };
      };
  };
}
