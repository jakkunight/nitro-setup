let
  feature = "nushell";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          nushell
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        programs.nushell = {
          enable = true;
        };
      };
  };
}
