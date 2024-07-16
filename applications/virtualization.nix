# Install virtualization utilities:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # QUEMU:
    qemu
    quickemu
    # Docker:
    docker
    # Kubernetes:
    kubernetes
  ];
}
