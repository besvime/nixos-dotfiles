{ config, pkgs, ... }:

{
  home.username = "noir";
  home.homeDirectory = "/home/noir";

  home.packages = with pkgs; [
    brave
    discord
    vesktop
    spotify
    input-remapper
    grim
    slurp
    satty
    wl-clipboard
    qownnotes
    wlogout
    mako
    xwayland-satellite
    swayfx
    soteria
    rofi
    neovim
    # new
    swww
    waypaper
  ];
  
  # configs
  home.file.".config/mango".source = ./config/mango;

  # programs
  programs.git = {
    enable = true;
    settings = {
      user.name = "Cat";
      user.email = "bodyglue4@gmail.com";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # settings
  dconf.enable = true;

  home.stateVersion = "25.05";
}
