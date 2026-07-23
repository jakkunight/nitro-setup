let
  feature = "scarlett2-firmware";
in
{ inputs, ... }:
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      hardware.firmware = [
        inputs.scarlett2-firmware-nix.packages.${pkgs.stdenv.hostPlatform.system}.scarlett2-firmware-nix
      ];
      services.fwupd.enable = true;
      environment.systemPackages = with pkgs; [ alsa-scarlett-gui ];
    };
}
