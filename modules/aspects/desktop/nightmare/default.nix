let
  feature = "nightmare-desktop";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = {
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
          ];
    };
    homeManager = {
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
            nightmare-hyprland
            nightmare-kitty
            nightmare-hypridle
            nightmare-hyprlock
            nightmare-ashell
            nightmare-wofi
            nightmare-zen-browser
            kitty
            foot
            ghostty
            zen-browser
            nightmare-waybar
            hyprwall
            swaync
            # ashell
            hyprlock
            hypridle
            zsh
            nightmare-zsh
            nushell
            qutebrowser
            remmina
            wofi
          ];
    };
  };
}
