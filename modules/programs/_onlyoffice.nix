let
  feature = "onlyoffice";
in
{
  flake.modules = {
    nixos.${feature} = { };
    homeModules.${feature} = { };
  };
}
