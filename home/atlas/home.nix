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
  ];
  
  # configs
  home.file.".config/sway".source = ./config/sway;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/mako".source = ./config/mako;

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
