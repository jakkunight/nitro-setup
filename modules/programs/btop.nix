let
  feature = "btop";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          btop
        ];
      };
    homeManager.${feature} = {
      programs.btop = {
        enable = true;
      };
    };
  };
}
