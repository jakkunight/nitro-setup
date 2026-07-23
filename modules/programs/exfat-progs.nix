let
  feature = "exfat-progs";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        exfatprogs
        exfat
      ];
    };
}
