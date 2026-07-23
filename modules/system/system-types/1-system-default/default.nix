{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos."1-system-default" = { pkgs, ... }: {
    imports = with self.modules.generic; [
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
    system.stateVersion = "26.05";
  };
}
