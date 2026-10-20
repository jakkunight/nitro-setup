let
  feature = "discord";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          # discord-canary
          # discord
          discord-ptb
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        programs.discord = {
          enable = true;
          # package = pkgs.discord-canary;
          # package = pkgs.discord;
          package = pkgs.discord-ptb;
        };
      };
  };

}
