let
  feature = "zsh";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = {
      programs.zsh = {
        enable = true;
        autosuggestions = {
          enable = true;
        };
        syntaxHighlighting.enable = true;
        enableCompletion = true;
      };
    };
    homeManager = {
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
      };
    };
  };

}
