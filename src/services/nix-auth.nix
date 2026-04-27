let
  feature = "nix-auth";
in
{
  inputs,
  ...
}:
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.nix-auth.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
