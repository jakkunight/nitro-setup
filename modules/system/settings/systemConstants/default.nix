{ lib, ... }:
{
  flake.modules.generic.systemConstants = { lib, ... }: {
    options.systemConstants = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = { };
    };

    config.systemConstants = {
      adminEmail = "admin@jakku.sh";
      defaultLocale = "es_PY.UTF-8";
      defaultTimeZone = "America/Asuncion";
      defaultKeyLayout = "latam";
    };
  };
}
