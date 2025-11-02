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

  time.timeZone = "America/New_York";

  hardware.enableAllFirmware = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; import ../../pkgs/sys-pkgs.nix { inherit pkgs; };
  fonts.packages = with pkgs; import ../../pkgs/fonts.nix { inherit pkgs; };

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  # accounts
  users.users.noir = {
    isNormalUser = true;
    description = "Noir";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # programs
  programs = {
      firefox.enable = true;
      steam.enable = true;
      xwayland.enable = true;
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };
  };

  # desktop portal
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = ["gtk"];
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # services & security
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
    flatpak.enable = true;
    xserver.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome.gnome-keyring.enable = true;
    input-remapper = {
      enable = true;
      enableUdevRules = true;
    };

    # audio
    pipewire = {
      enable = true;
      alsa = { enable = true; support32Bit = true; };
      jack.enable = true;
      pulse.enable = true;
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
