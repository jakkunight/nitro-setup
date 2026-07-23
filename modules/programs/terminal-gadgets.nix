let
  feature = "terminal-gadgets";
in
{ self, ... }:
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        imports = with self.modules.nixos; [
          clock-rs
          fastfetch
          speedtest-rs
          cava
        ];
      };
    homeManager.${feature} = {
      imports = with self.modules.homeManager; [
        clock-rs
        fastfetch
        speedtest-rs
        cava
      ];
    };
  };
}
