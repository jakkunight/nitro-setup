_: let
  moduleName = "applications/wireshark";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark-qt;
        dumpcap.enable = true;
        usbmon.enable = true;
      };
      environment.systemPackages = with pkgs; [
        termshark
      ];
    };
  };
}
