let
  feature = "zsh";
in
{
  flake.modules = {
    nixos.${feature} = {
      programs.zsh = {
        enable = true;
        autosuggestions = {
          enable = true;
        };
        syntaxHighlighting.enable = true;
        enableCompletion = true;
      };
    };
    homeManager.${feature} = {
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
      };
    };
  };
}
