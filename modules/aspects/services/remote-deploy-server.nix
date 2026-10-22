let
  feature = "remote-deploy-server";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos =
    { ... }:
    {
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "prohibit-password";
        };
      };

      networking.firewall.interfaces.wg0.allowedTCPPorts = [ 22 ];

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOpMSHJxs/M0lwtGhYNwQ+wN/FngIY2HR9bOjji3k1a deploy@germain"
      ];
    };
}
