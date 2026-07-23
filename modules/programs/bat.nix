let
  feature = "bat";
in
{
  flake.modules = {
    nixos.${feature} = {
      programs.bat = {
        enable = true;
      };
    };
    homeManager.${feature} = {
      programs.bat = {
        enable = true;
      };
    };
  };
}
