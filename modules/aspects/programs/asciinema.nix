let
  feature = "asciinema";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          asciinema
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        programs.asciinema.enable = true;
      };
  };

}
