let
  feature = "oracle";
in
{
  inputs,
  ...
}:
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      imports = [
        inputs.oracle-database.nixosModules.oracle-database-container
      ];
      services.oracle-database-container = {
        enable = true;
        openFirewall = true;
        volumeName = "oracledb";
      };
    };
}
