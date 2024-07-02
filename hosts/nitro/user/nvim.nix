# Here goes all the stuffs for my NeoVim setup with 
# Home-Manager and NixOS:
{ config, lib, pkgs, ... }@inputs: {
  # NeoVim:
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      # Telescope
      ripgrep
      fd
      lazygit
      luajitPackages.luarocks
    ];
    plugins = with pkgs.vimPlugins; [
      #lazy-nvim
      LazyVim
    ];
  };
}



