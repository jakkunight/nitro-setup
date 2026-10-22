let
  feature = "wireguard-secrets";
in
{ inputs, den, ... }:
{
  den.aspects.${feature}.nixos =
    { lib, pkgs, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.systemPackages = with pkgs; [
        wireguard-tools
      ];

      sops.age.keyFile = lib.mkDefault "/home/jakku/.config/sops/age/keys.txt";
    };
}
