{ config, lib, pkgs, ... }:
{
  networking.hostName = "jdnixlt";
  boot.loader.efi.canTouchEfiVariables = true;
}
