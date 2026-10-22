let
  feature = "remote-deploy-client";
in
{ inputs, den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      imports = [
        den.aspects.wireguard-secrets.nixos
      ];

      sops.secrets.germain_deploy_ssh_key = {
        sopsFile = ../../secrets/deploy-ssh.yaml;
        key = "germain_deploy_ssh_key";
        owner = "jakku";
        mode = "0400";
      };

      environment.systemPackages = [
        pkgs.openssh
        inputs.deploy-rs.packages.${pkgs.stdenv.hostPlatform.system}.deploy-rs
      ];
    };
}
