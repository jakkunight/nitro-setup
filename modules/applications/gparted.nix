_: let
  moduleName = "applications/gparted";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        gparted
        exfatprogs
        exfat
      ];
    };
  };
}
