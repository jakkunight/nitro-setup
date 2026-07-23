let
  feature = "starship";
in
{
  flake.modules = {
    nixos.${feature} = {
      programs.starship = {
        enable = true;
        settings = {
          add_newline = true;
        };
      };
    };
    homeManager.${feature} = {
      programs.starship = {
        enable = true;
        settings = {
          add_newline = true;
        };
      };
    };
  };
}
