# Neovim config:
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # LazyVim
      vimPlugins.LazyVim
      lua-language-server
      stylua
      # Telescope
      ripgrep
      fd
      lazygit
      luajitPackages.luarocks
    ];
    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];
  };
}
