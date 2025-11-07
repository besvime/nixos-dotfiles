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
					./hosts/configuration.nix
					mango.nixosModules.mango
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
	};
}
