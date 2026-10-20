let
  feature = "oracle";
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
      imports = [
        inputs.oracle-database.nixosModules.oracle-database-container
      ];
      services.oracle-database-container = {
        enable = true;
        openFirewall = true;
        volumeName = "oracledb";
        memoryLimit = "1G";
        memoryReservation = "512M";
        swapLimit = "512M";
      };
    };
}
