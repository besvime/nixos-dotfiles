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
      mango.enable = true;
      steam.enable = true;
      xwayland.enable = true;
  };

  services = {
    displayManager.gdm.enable = true;
    desktopManager.plasma6.enable = true;
    
    input-remapper = {
      enable = true;
      enableUdevRules = true;
    };
  };

  # auto-mounted drives
  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/b3bfd701-8b8b-45a8-a3f1-35213720a5dd"; 
    fsType = "ext4";
    options = [ "rw" "exec" "suid" "dev" "nofail" ];
  };

  system.stateVersion = "25.05";
}
