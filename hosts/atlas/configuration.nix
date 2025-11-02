{ config, pkgs, ... }:

{
  imports = [
      /etc/nixos/hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices."luks-3f758e19-7163-4979-a642-f6d029d9cb7f".device = "/dev/disk/by-uuid/3f758e19-7163-4979-a642-f6d029d9cb7f";
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "pcie_aspm=off" ];

    extraModprobeConfig = ''
      options ath12k debug_mask=0
      options ath12k_pci allow_2bit_msi=0
    '';
    
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "atlas";

  # programs
  programs = {
      steam.enable = true;
      xwayland.enable = true;
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };
  };

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    
    input-remapper = {
      enable = true;
      enableUdevRules = true;
    };
  };

  # auto-mounted drives
  fileSystems."/mnt/Games" = {
    device = "/dev/nvme0n1p4";
    fsType = "ext4";
    options = [ "rw" "exec" "suid" "dev" "nofail" ];
  };

  system.stateVersion = "25.05";
}
