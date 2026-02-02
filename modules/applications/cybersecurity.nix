_: let
  moduleName = "cybersecurity";
in {
  flake.modules.nixos.${moduleName} = {pkgs, ...}: {};
  flake.modules.homeManager.${moduleName} = {pkgs, ...}: {};
}
