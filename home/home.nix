{ config, pkgs, ... }:

{
	home.username = "noir";
	home.homeDirectory = "/home/noir";
  	home.packages = with pkgs; import ../pkgs/usr-pkgs.nix { inherit pkgs; };

	# configs
	home.file.".config/sway".source = ./config/sway;
	home.file.".config/rofi".source = ./config/rofi;
	home.file.".config/mako".source = ./config/mako;

	# programs
	programs.git = {
        enable = true;
        userName = "Cat";
        userEmail = "bodyglue4@gmail.com";
      };
	programs.bash = {
		enable = true;
		enableCompletion = true;
	};

	# settings
	dconf = {
		enable = true;
	};
	
	home.stateVersion = "25.05";
}
