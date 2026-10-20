let
  feature = "onlyoffice";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = { };
  homeModules.${feature} = { };

}
