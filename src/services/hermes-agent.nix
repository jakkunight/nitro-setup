let
  feature = "hermes-agent";
in
{
  inputs,
  ...
}:
{
  flake.modules.nixos.${feature} = { pkgs, ... }: {
    imports = [
      inputs.hermes-agent.nixosModules.default
    ];
    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;
    };
  };
}
