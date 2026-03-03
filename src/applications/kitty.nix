let
  feature = "kitty";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          kitty
        ];
      };
    homeManager.${feature} = _: {
      programs.kitty = {
        enable = true;
      };
    };
  };
}
