# SDDM config:
{ pkgs }:
{
  services.displayManager.sddm = {
    enable = true;
    theme = "${import ./../assets/sddm-theme.nix { inherit pkgs; }}";
  };
}
