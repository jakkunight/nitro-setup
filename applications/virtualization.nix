# Install virtualization utilities:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # QUEMU:
    qemu
    quickemu
    qemu_kvm
    # Docker:
    docker
    # Kubernetes:
    kubernetes
  ];
}
