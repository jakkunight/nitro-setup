let
  feature = "scarlett2-firmware";
in
{ inputs, den, ... }:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      hardware.firmware = [
        inputs.scarlett2-firmware-nix.packages.${pkgs.stdenv.hostPlatform.system}.scarlett2-firmware-nix
      ];
      services.fwupd.enable = true;
      environment.systemPackages = with pkgs; [ alsa-scarlett-gui ];
    };
}
