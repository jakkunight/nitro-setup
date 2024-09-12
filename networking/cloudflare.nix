{ pkgs, lib, config, ... }@inputs:

{
  services.cloudflared = {
    enable = false;
  };
}
