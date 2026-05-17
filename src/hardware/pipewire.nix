let
  feature = "pipewire";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          audio.enable = true;
          wireplumber = {
            enable = true;
            package = pkgs.wireplumber;
          };
          pulse.enable = true;
          jack.enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          # For low-latency
          # extraConfig.pipewire."92-low-latency" = {
          #   "context.properties" = {
          #     "default.clock.rate" = 48000;
          #     "default.clock.quantum" = 32;
          #     "default.clock.min-quantum" = 32;
          #     "default.clock.max-quantum" = 32;
          #   };
          # };
        };
        environment.systemPackages = with pkgs; [
          pavucontrol
          bluez5
          alsa-utils
        ];
      };
  };
}
