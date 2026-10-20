{
  self,
  inputs,
  den,
  ...
}:
{
  den.aspects."5-system-desktop" = {
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
            "4-system-cli"
            stylix
            nightmare-desktop
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
  };

}
