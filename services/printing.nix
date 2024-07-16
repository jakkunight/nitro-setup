# Enable CUPS for printing:
{ config, lib, pkgs, inputs, ... }:
{
  services.printing.enable = true;
}
