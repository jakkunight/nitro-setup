let
  feature = "serpantinum-shell";
in
{
  self,
  inputs,
  den,
  ...
}:
{
  den.aspects.${feature} = {
    nixos = { pkgs, ... }: {
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
            inputs.serpantinum.nixosModules.default
            hyprland
            hyprland-nvidia
            kitty
            foot
            ghostty
          ];
      programs.serpantinum.enable = true;
    };
    homeManager = { pkgs, ... }: {
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
            inputs.serpantinum.nixosModules.default
            nightmare-hyprland
            kitty
            foot
            ghostty
            zen-browser
            zsh
            nushell
            remmina
          ];
      programs.serpantinum.enable = true;
    };
  };

}
