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
    xwayland-satellite
    swayfx
    soteria
    neovim
    # ricing
    wlogout
    mako
    fuzzel
    swww
    waypaper
    waybar
    # too much rn | swaync
    pamixer
    pavucontrol
  ];
  
  # configs
  home.file.".config/mango".source = ./config/mango;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/mako".source = ./config/mako;
  home.file.".config/fuzzel".source = ./config/fuzzel;

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
