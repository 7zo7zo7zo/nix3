{ inputs, ... }:

{
	flake = {
		aspects = { aspects, ... }: {
			host-nitro = let
				primaryUser = "steve";
			in {
				description = "Configuration for my Acer Nitro 5 AN515-54";

				includes = with aspects; [
					base
					user
					zsh
					drives
					dwm
					audio
					bluetooth
					printing	
					xdg
					nvim
					st
					firefox
					obsidian
					mpv
					nsxiv
					zathura
					tmux
					nnn
					syncthing
					fastfetch
				];

				nixos = {config, pkgs, ...}: {
					imports = [
						./_hardware-configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];

					services.picom = {
						enable = true;
						backend = "glx";
						vSync = false;

						fade = false;
						shadow = false;
						inactiveOpacity = 1.0;
					};

					services.udisks2.enable = true;

					environment.localBinInPath = true;

					networking.hostName = "nitro";
					system.stateVersion = "26.05";
					inherit primaryUser;

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						users.${config.primaryUser} = {
							imports = [ aspects.host-nitro.modules.homeManager ];
						};
					};
				};

				homeManager = { pkgs, ... }: {
					home.stateVersion = "26.05";
					inherit primaryUser;

					home.packages = with pkgs; [
						pavucontrol
						# gimp
						# krita
						# screenkey
					];

					services.udiskie = {
						enable = true;
					};

					home.sessionVariables = {
						TERMINAL = "st";
						BROWSER = "firefox";
						EDITOR = "nvim";
						VISUAL = "nvim";
						PAGER = "less";
					};
				};
			};
		};

		nixosConfigurations.nitro = inputs.nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			modules = [ inputs.self.modules.nixos.host-nitro ];
		};
	};
}
