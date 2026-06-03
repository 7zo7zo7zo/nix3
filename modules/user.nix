{
	flake.aspects.user =
	{
		nixos = {pkgs, config, lib, ...}: {
			options.primaryUser = lib.mkOption {
				type = lib.types.singleLineStr;
				default = "";
				description = "Primary user for this NixOS host";
			};

			config = {
				programs.zsh.enable = true;

				users.users.${config.primaryUser} = {
					isNormalUser = true;
					home = "/home/${config.primaryUser}";
					shell = pkgs.zsh;
					extraGroups = [ "wheel" "audio" "video" ];
				};
			};
		};

		homeManager = { config, lib, ... }: {
			options.primaryUser = lib.mkOption {
				type = lib.types.singleLineStr;
				default = "";
				description = "Primary user for this Home Manager profile";
			};

			config = {
				home.username = "${config.primaryUser}";
				home.homeDirectory = "/home/${config.primaryUser}";
			};
		};
	};
}
