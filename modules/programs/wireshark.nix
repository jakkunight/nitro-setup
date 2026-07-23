let
  feature = "wireshark";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
      environment.systemPackages = with pkgs; [
        termshark
      ];
    };
}
