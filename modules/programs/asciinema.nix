let
  feature = "asciinema";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        asciinema
      ];
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      programs.asciinema.enable = true;
    };
}
