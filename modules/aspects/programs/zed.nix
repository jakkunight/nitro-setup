let
  feature = "zed";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          zed-editor
        ];
      };
    homeManager = _: {
      programs.zed-editor = {
        enable = true;
      };
    };
  };

}
