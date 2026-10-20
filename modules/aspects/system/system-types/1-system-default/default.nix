{
  self,
  inputs,
  lib,
  den,
  ...
}:
{
  den.aspects."1-system-default".nixos = { pkgs, ... }: {
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
          systemConstants
        ];
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    i18n.defaultLocale = "es_PY.UTF-8";
    time.timeZone = "America/Asuncion";
    services.xserver.xkb.layout = "latam";
    services.libinput.enable = true;
    system.stateVersion = "26.11";
  };
}
