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
      Install.WantedBy = [ "graphical-session.target" "mango-session.target"];
    };
    
  in {
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

    kde-polkit = (start-with-graphical-session "KDE polkit service") // {
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };

  home.stateVersion = "25.05";
}
