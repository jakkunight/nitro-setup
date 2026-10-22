{
  self,
  inputs,
  ...
}:
{
  flake.deploy.nodes.germain = {
    hostname = "10.44.0.1";
    sshUser = "root";
    sshOpts = [
      "-i"
      "/run/secrets/germain_deploy_ssh_key"
      "-o"
      "IdentitiesOnly=yes"
    ];
    profiles.system = {
      user = "root";
      path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.germain;
    };
  };

  perSystem =
    { system, ... }:
    {
      checks = inputs.deploy-rs.lib.${system}.deployChecks self.deploy;
    };
}
