{ config, pkgs, ... }:

{
  # Shared defaults for all hosts
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  time.timeZone = "America/New_York";

  # networking
  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  # Common user
  users.users.noir = {
    isNormalUser = true;
    description = "Noir";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Shared environment packages
  environment.systemPackages = with pkgs; import ../pkgs/sys-pkgs.nix { inherit pkgs; };
  fonts.packages = with pkgs; import ../pkgs/fonts.nix { inherit pkgs; };

  # Common programs
  programs = {
    firefox.enable = true;
    steam.enable = true;
    xwayland.enable = true;
  };

  # Common audio & services
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };

    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    input-remapper = {
      enable = true;
      enableUdevRules = true;
    };
  };

  # Portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = [ "gtk" ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  system.stateVersion = "25.05";
}