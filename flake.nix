{
	description = "NixOS for Life";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	

	outputs = { self, nixpkgs, home-manager, stylix, ... }: {
		nixosConfigurations.origami = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				stylix.nixosModules.stylix
				./hosts/noir/configuration.nix
				home-manager.nixosModules.home-manager

				{ # settings
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.noir = import ./home/home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
 	};
}
