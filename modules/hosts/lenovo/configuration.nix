{ inputs, ... }:

{
	flake = {
		aspects =
		{ aspects, ... }:
		{
			host-lenovo = {
				description = "Configuration for my Lenovo IdeaPad 130-15AST";

				includes = with aspects; [
					base
					user
					audio
					printing	
				];

				nixos = {
					imports = [
						./_hardware-configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];

					networking.hostName = "lenovo";
					system.stateVersion = "25.11";

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						users.steve = {
							imports = [ aspects.host-lenovo.modules.homeManager ];
						};
					};
				};

				homeManager = {
					home.stateVersion = "25.11";
				};
			};
		};

		nixosConfigurations.lenovo = inputs.nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			modules = [ inputs.self.modules.nixos.host-lenovo ];
		};
	};
}
