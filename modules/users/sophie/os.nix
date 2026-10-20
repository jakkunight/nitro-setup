let
  user = "sophie";
in
{ den, ... }:
{
  den.aspects."${user}-os".nixos =
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
            core
            gaming
            libvirt
          ];

      home-manager = {
        useGlobalPkgs = false;
        useUserPackages = false;
        backupFileExtension = "backup";
      };

      environment.sessionVariables = {
        EDITOR = "hx";
      };
    };
}
