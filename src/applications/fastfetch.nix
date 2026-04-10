let
  feature = "fastfetch";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          fastfetch
        ];
      };
    homeManager.${feature} = {
      programs.fastfetch = {
        enable = true;
      };
    };
  };
}
