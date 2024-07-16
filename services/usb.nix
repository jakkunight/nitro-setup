# USB Services:
{ ... }:
{
  # Enable GVFS to mount USB drives:
  services.gvfs.enable = true;

  # Enable udisks2:
  services.udisks2.enable = true;

  # Enable udiskie:
  services.udiskie = {
    enable = true;
    notify = true;
    try = true;
  };
}
