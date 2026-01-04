_: let
  moduleName = "applications/krita";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        krita
      ];
    };
  };
}
