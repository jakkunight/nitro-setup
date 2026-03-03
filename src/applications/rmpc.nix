let
  feature = "rmpc";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          rmpc
        ];
      };
    homeManager.${feature} = {
      programs.rmpc = {
        enable = true;
      };
    };
  };
}
