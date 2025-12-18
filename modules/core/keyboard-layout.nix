_: {
  flake.modules.nixos."keyboard-layout" = _: {
    i18n.defaultLocale = "es_PY.UTF-8";
    services.xserver.enable = true;
    services.xserver.xkb.layout = "latam";
    services.libinput.enable = true;
  };
}
