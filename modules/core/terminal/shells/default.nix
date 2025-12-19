_: {
  flake.modules.nixos."terminal/shells/default" = {pkgs, ...}: {
    users.defaultUserShell = pkgs.bash;
  };
}
