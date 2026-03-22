let
  feature = "foot";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          foot
        ];
      };
    homeManager.${feature} = _: {
      programs.foot = {
        enable = true;
      };
    };
  };
}
