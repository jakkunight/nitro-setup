_: let
  moduleName = "terminal/utils/widgets";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        clock-rs
        cava
        fastfetch
        pipes-rs
        speedtest-rs
      ];
    };
  };
}
