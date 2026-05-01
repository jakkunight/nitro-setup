let
  feature = "discord";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          # discord-canary
          discord
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        programs.discord = {
          enable = true;
          # package = pkgs.discord-canary;
          package = pkgs.discord;
        };
      };
  };
}
