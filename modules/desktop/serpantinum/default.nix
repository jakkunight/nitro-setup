let
  feature = "serpantinum-shell";
in
{ inputs, ... }:
{
  flake.modules.nixos.${feature} = { pkgs, ... }: {
    imports = [
      inputs.serpantinum.nixosModules.default
    ];
    programs.serpantinum.enable = true;
  };
  flake.modules.homeManager.${feature} = { pkgs, ... }: {
    imports = [
      inputs.serpantinum.nixosModules.default
    ];
    programs.serpantinum.enable = true;
  };
}
