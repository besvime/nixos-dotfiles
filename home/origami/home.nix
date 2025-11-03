{ config, pkgs, ... }:

{
  home.username = "noir";
  home.homeDirectory = "/home/noir";

  home.packages = with pkgs; [
    vesktop
    spotify
    spicetify-cli
    
    rofi
    mako
    wlogout
    swww
    nautilus
    waybar
    
    polkit_gnome
    xwayland-satellite
  ];
  
  # configs
  home.file.".config/niri".source = ./config/niri;

  # programs
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "Cat";
        user.email = "bodyglue4@gmail.com";
      };
    };

    bash = {
      enable = true;
      enableCompletion = true;
    };
  };

  # settings
  dconf.enable = true;

  home.stateVersion = "25.05";
}
