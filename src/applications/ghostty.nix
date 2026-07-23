let
  feature = "ghostty";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ghostty
        ];
      };
    homeManager.${feature} = _: {
      programs.ghostty = {
        enable = true;
      };
    };
  };
}
