_: let
  moduleName = "terminal/utils/nmap";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        nmap
      ];
    };
  };
}
