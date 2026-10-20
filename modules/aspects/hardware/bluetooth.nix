let
  feature = "bluetooth";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
      };
      services.blueman.enable = true;
      environment.systemPackages = with pkgs; [
        bluetuith
      ];
    };

}
