_: {
  flake.modules.nixos."terminal/shells/jakku" = {pkgs, ...}: {
    programs.zsh = {
      enable = true;
      shellInit = ''
        ${pkgs.fastfetch}/bin/fastfetch
      '';
      autosuggestions = {
        enable = true;
      };
      enableSyntaxHighlighting = true;
      enableCompletion = true;
    };
    users.users."jakku".shell = pkgs.zsh;
    users.users."jakku".useDefaultShell = false;
  };
  flake.modules.homeModules."terminal/shells/jakku" = {pkgs, ...}: {
    programs.zoxide.enableZshIntegration = true;
    programs.zoxide.enable = true;
  };
}
