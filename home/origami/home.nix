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
    start-with-graphical-session = description: {
      Unit = {
        Description = description;
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        BindsTo = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };
      Install.WantedBy = [ "graphical-session.target" "niri-session.service" ];
    };
  in {
    wallpaper = (start-with-graphical-session "Wallpaper service") // {
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/nixos-dotfiles/assets/wallpapers/mountain.jpg -m fill";
        Restart = "on-failure";
      };
    };

    idle = (start-with-graphical-session "Idle service") // {
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f'";
        Restart = "on-failure";
      };
    };

    waybar = (start-with-graphical-session "Waybar service") // {
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
      };
    };

    mako = (start-with-graphical-session "Mako service") // {
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.mako}/bin/mako";
        Restart = "on-failure";
      };
    };

    polkit = (start-with-graphical-session "Polkit service") // {
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };

  home.stateVersion = "25.05";
}
