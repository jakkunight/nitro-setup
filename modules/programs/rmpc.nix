let
  feature = "rmpc";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          rmpc
        ];
      };
    homeManager.${feature} =
      { config, ... }:
      {
        programs.rmpc = {
          enable = true;
          config = ''
            (
                address: "127.0.0.1:6600",
                cache_dir: Some("/home/${config.home.username}/.cache/rmpc"),
                volume_step: 5,
                enable_mouse: true,
                enable_config_hot_reload: true,
            )
          '';
        };
      };
  };
}
