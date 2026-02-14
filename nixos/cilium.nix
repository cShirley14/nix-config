{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [ pkgs.cilium-cli ];
}
