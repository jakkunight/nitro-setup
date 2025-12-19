_: let
  module = "terminal/utils/bat";
in {
  flake.modules = {
    nixos.${module} = _: {
      programs.bat = {
        enable = true;
      };
      environment.shellAliases = {
        cat = "bat";
      };
    };
    homeManager.${module} = _: {
      programs.bat = {
        enable = true;
      };
      home.shellAliases = {
        cat = "bat";
      };
    };
  };
}
