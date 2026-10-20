let
  feature = "vmware";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = {
    virtualisation.vmware = {
      host.enable = true;
      guest.enable = true;
    };
  };
}
