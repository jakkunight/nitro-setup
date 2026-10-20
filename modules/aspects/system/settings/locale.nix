let
  feature = "locale";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = {
    i18n.defaultLocale = "es_PY.UTF-8";
    time.timeZone = "America/Asuncion";
    services.xserver.xkb.layout = "latam";
    services.libinput.enable = true;
  };
}
