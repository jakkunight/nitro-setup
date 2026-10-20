let
  feature = "nightmare-waybar";
in
{
  inputs,
  self,
  den,
  ...
}:
{
  den.aspects.${feature}.homeManager = { pkgs, lib, ... }: {

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
          waybar
        ];
  };
}
