{ config, pkgs, ... }:

{
  imports = [
      /etc/nixos/hardware-configuration.nix
  ];
  
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "origami";

  # programs
  programs = {
      niri.enable = true;
      xwayland.enable = true;
  };

  services = {
    displayManager.gdm.enable = true;
  };

  system.stateVersion = "25.05";
}
