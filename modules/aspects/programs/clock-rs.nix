let
  feature = "clock-rs";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          clock-rs
        ];
      };
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        clock-rs
      ];
    };
  };

}
