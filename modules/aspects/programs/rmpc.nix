let
  feature = "rmpc";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          rmpc
        ];
      };
    homeManager =
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
