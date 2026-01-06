_: let
  moduleName = "applications/wireshark";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        wireshark-qt
        termshark
      ];
    };
  };
}
