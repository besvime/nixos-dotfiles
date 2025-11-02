{
	description = "NixOS for Life";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
	};
	

	outputs = { self, nixpkgs, home-manager, ... }: {
		nixosConfigurations.origami = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/base.nix
				./hosts/origami/configuration.nix
				home-manager.nixosModules.home-manager

				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.noir = import ./home/home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};


		nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/base.nix
				./hosts/atlas/configuration.nix
				home-manager.nixosModules.home-manager

				{
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
