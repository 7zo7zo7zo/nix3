{ inputs, ... }:

{
	flake = {
		aspects = { aspects, ... }: {
			host-lenovo = let
				primaryUser = "steve";
			in {
				description = "Configuration for my Lenovo IdeaPad 130-15AST";

				includes = with aspects; [
					base
					user
					zsh
					dwm
					audio
					bluetooth
					printing	
					xdg
					nvim
					st
					firefox
					obsidian
				];

				nixos = {config, ...}: {
					imports = [
						./_hardware-configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];

					networking.hostName = "lenovo";
					system.stateVersion = "25.11";
					inherit primaryUser;

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						users.${config.primaryUser} = {
							imports = [ aspects.host-lenovo.modules.homeManager ];
						};
					};
				};

				homeManager = {
					home.stateVersion = "25.11";
					inherit primaryUser;
				};
			};
		};

		nixosConfigurations.lenovo = inputs.nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			modules = [ inputs.self.modules.nixos.host-lenovo ];
		};
	};
}
