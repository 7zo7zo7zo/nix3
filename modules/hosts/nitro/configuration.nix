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
					steam
					emulator
				];

				nixos = {config, pkgs, ...}: {
					imports = [
						./_hardware-configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];


					# cat /proc/driver/nvidia/gpus/0000:01:00.0/power
					# Runtime D3 status:          Enabled (fine-grained)
					boot.kernelParams = [
						"nvidia.NVreg_EnableGpuFirmware=0"
						#"nvidia.NVreg_DynamicPowerManagement=0x02"
						#"nvidia.NVreg_PreserveVideoMemoryAllocations=1"
					];

					hardware.graphics = {
						enable = true;
					};

					services.xserver.videoDrivers = [ "nvidia" ];

					hardware.nvidia = {
						modesetting.enable = true;
						powerManagement.enable = true; # Needed for suspend to work?
						powerManagement.finegrained = true;
						open = false;
						nvidiaSettings = true;

						package = config.boot.kernelPackages.nvidiaPackages.stable;

						prime = {
							offload = {
								enable = true;
								enableOffloadCmd = true;
							};

							intelBusId = "PCI:0:2:0";
							nvidiaBusId = "PCI:1:0:0";
						};
					};

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
