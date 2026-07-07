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
					passwords
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
					minecraft
					office
					doom
					#steam
					#emulator
				];

				nixos = {config, pkgs, ...}: {
					imports = [
						./_hardware-configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];

					hardware.graphics.enable = true;
					services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
					hardware.nvidia.open = false;

/*
					hardware.nvidia.prime = {
						offload = {
							enable = true;
							enableOffloadCmd = true;
						};

						intelBusId = "PCI:0@0:2:0";
						nvidiaBusId = "PCI:1@0:0:0";
					};
					*/

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
