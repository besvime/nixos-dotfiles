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
    swaybg
    swaylock
    nautilus
    waybar
    
    polkit_gnome
    xwayland-satellite
  ];
  
  # configs
  home.file.".config/niri".source = ./config/niri;
  home.file.".config/mako".source = ./config/mako;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/waybar".source = ./config/waybar;

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

  # systemd services
  systemd.user.services = let
    start-with-graphical-session = Description: {
      Unit = {
        inherit Description;
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
        BindsTo = ["graphical-session.target"];
        Requisite = ["graphical-session.target"];
      };
      Install.WantedBy = ["graphical-session.target" "niri-session.service"];
    };
  in {
    wallpaper = start-with-graphical-session "Wallpaper service"
    // {
      Service = {
        Type = "simple";
        ExecStart = "swaybg -i ~/nixos-dotfiles/assets/wallpapers/mountain.jpg -m fill";
        Restart = "on-failure";
      };
    };

    idle = start-with-graphical-session "Idle service"
    // {
      Service = {
        Type = "simple";
        ExecStart = "swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f'";
        Restart = "on-failure";
      };
    };

    waybar = start-with-graphical-session "Waybar service"
    // {
      Service = {
        Type = "simple";
        ExecStart = "waybar";
        Restart = "on-failure";
      };
    };


    mako = start-with-graphical-session "Mako service"
      // {
        Service = {
          Type = "simple";
          ExecStart = "mako";
          Restart = "on-failure";
        };
      };
  };

  home.stateVersion = "25.05";
}
