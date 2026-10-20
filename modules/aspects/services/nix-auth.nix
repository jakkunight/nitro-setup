let
  feature = "nix-auth";
in
{
  inputs,
  den,
  ...
}:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.nix-auth.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
