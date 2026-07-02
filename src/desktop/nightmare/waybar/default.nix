let
  feature = "nightmare-waybar";
in
{ inputs, self, ... }: {
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {

    imports = with self.modules.homeManager; [
      waybar
    ];
  };
}
