{
	description = "NixOS for Life";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		mango.url = "github:DreamMaoMao/mangowc";
	};

	outputs = { self, nixpkgs, home-manager, mango, ... }: {
		nixosConfigurations = {
			atlas = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/base.nix
					./hosts/atlas/configuration.nix
					mango.nixosModules.mango
					home-manager.nixosModules.home-manager

					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.noir = import ./home/atlas/home.nix;
							backupFileExtension = "backup";
						};
					}
				];
			};

			origami = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/base.nix
					./hosts/origami/configuration.nix
					home-manager.nixosModules.home-manager

					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.noir = import ./home/origami/home.nix;
							backupFileExtension = "backup";
						};
					}
				];
			};
		};
	};
}
