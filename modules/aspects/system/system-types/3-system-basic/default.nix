{
  self,
  inputs,
  den,
  ...
}:
{
  den.aspects."3-system-basic".nixos = {
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
          "2-system-essential"
          core
          ntfs3g
        ];
  };
}
