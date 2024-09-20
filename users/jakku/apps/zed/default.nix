{ pkgs, lib, config, inputs, ... }:

{
  # Install Zed editor:
  home.packages = with pkgs; [
    zed-editor
  ];
}
