let
  feature = "clock-rs";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          clock-rs
        ];
      };
    homeManager.${feature} = {pkgs, ...}:{
		home.packages = with pkgs; [
			clock-rs
		];
    };
  };
}
