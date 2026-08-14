let
  feature = "openspec";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          openspec
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
		home.packages = with pkgs; [
			openspec
		];
      };
  };
}
