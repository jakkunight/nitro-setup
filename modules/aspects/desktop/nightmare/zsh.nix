let
  feature = "nightmare-zsh";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { pkgs, lib, ... }:
    {
      programs.zsh.initContent = lib.mkOrder 1200 ''
        clear
        ${pkgs.fastfetch}/bin/fastfetch
        echo "Welcome back, $USER! (^.^)"
      '';
    };
}
