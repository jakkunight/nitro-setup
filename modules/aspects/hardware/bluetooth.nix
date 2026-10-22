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
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };
      services.blueman.enable = true;
      environment.systemPackages = with pkgs; [
        bluetuith
      ];
    };

}
