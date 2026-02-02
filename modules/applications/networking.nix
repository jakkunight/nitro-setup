_: let
  moduleName = "networking";
in {
  flake.modules.nixos.${moduleName} = {pkgs, ...}: {};
  flake.modules.homeManager.${moduleName} = {pkgs, ...}: {};
}
