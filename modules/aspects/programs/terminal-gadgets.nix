let
  feature = "terminal-gadgets";
in
{ self, den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
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
              clock-rs
              fastfetch
              speedtest-rs
              cava
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
            clock-rs
            fastfetch
            speedtest-rs
            cava
          ];
    };
  };

}
