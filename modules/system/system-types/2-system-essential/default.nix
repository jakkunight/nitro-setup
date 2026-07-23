{ self, inputs, ... }:
{
  flake.modules.nixos."2-system-essential" = {
    imports = with self.modules.nixos; [
      "1-system-default"
      pipewire
      zram
      bluetooth
      networking
      disk
    ];
  };
}
