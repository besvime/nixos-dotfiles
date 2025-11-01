{ pkgs }:
with pkgs; [
    # Basic needs
    alacritty
    vscode

    # needed for basic wm usage
    wlogout
    mako
    xwayland-satellite
    swayfx
    soteria
    rofi
]
