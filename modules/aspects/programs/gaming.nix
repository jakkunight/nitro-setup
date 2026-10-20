let
  feature = "gaming";
in
{ self, den, ... }:
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
            steam
            heroic
            discord
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
            steam
            heroic
            discord
          ];
    };
  };

}
