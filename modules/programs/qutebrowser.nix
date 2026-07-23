let
  feature = "qutebrowser";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          qutebrowser
        ];
      };
    homeManager.${feature} = {
      programs.qutebrowser = {
        enable = true;
      };
    };
  };
}
