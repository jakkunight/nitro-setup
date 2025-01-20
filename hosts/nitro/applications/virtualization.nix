# Install virtualization utilities:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # QUEMU:
    #qemu_full
    #qemu_kvm
    #nemu
    # Docker:
    docker
    # Kubernetes:
    kubernetes
    # VMWare:
    vmware-workstation
  ];
}
