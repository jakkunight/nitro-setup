let
  feature = "starship-desktop";
in
{
  self,
  inputs,
  den,
  ...
}:
{
  den.aspects.${feature} = {
    nixos =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports =
          with den.aspects;
          map
            (
              a:
              if builtins.isAttrs a && a ? nixos then
                (
                  let
                    v = a.nixos;
                  in
                  if builtins.isAttrs v && v ? __contentValues then
                    { imports = map (d: d.value) v.__contentValues; }
                  else
                    v
                )
              else if builtins.isAttrs a && a ? provides then
                { }
              else
                a
            )
            [
              hyprland
              hyprland-nvidia
              kitty
              foot
              ghostty
              starship-theme
            ];

      };
    homeManager =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        imports =
          with den.aspects;
          map
            (
              a:
              if builtins.isAttrs a && a ? homeManager then
                (
                  let
                    v = a.homeManager;
                  in
                  if builtins.isAttrs v && v ? __contentValues then
                    { imports = map (d: d.value) v.__contentValues; }
                  else
                    v
                )
              else if builtins.isAttrs a && a ? provides then
                { }
              else
                a
            )
            [
              starship-hyprland
              starship-quickshell
              kitty
              foot
              ghostty
              zen-browser
              hyprwall
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
