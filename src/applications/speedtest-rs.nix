let
  feature = "speedtest-rs";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          speedtest-rs
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          speedtest-rs
        ];
      };
  };
}
