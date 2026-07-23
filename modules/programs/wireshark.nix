let
  feature = "wireshark";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark-qt;
      };
      environment.systemPackages = with pkgs; [
        termshark
      ];
    };
}
