let
  user = "sophie";
in
{ den, ... }:
{
  den.aspects."${user}-home".homeManager = {
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
          core
          pandora-theme
          gaming
          nightmare-desktop
          swaync
          libreoffice
          nightmare-helix
          krita
        ];
    home = {
      stateVersion = "26.05";
      uid = 1002;
    };
  };
}
