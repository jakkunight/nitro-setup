let
  user = "sophie";
in
{ den, ... }:
{
  den.aspects."${user}-account".nixos =
    { pkgs, ... }:
    {
      users.groups.${user} = { };
      users.users.${user} = {
        group = user;
        isNormalUser = true;
        useDefaultShell = false;
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          "networkmanager"
          "input"
          "libvirtd"
        ];
        uid = 1002;
        initialPassword = user;
      };
    };
}
