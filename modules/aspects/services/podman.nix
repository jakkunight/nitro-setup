let
  feature = "podman";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = _: {
    virtualisation = {
      containers = {
        enable = true;
        registries.search = [ "docker.io" ];
      };
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };
  };
}
