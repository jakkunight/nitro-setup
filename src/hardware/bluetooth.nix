let
  feature = "bluetooth";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        hardware.bluetooth = {
          enable = true;
        };
        services.blueman.enable = true;
        environment.systemPackages = with pkgs; [
          blueberry
          bluetuith
        ];
      };
  };
}
