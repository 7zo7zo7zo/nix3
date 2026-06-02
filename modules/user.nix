{ inputs, ... }:

{
	flake.aspects.user =
	{
		nixos =
			{pkgs, ...}:
			{
				programs.zsh.enable = true;

				users.users.steve = {
					isNormalUser = true;
					home = "/home/steve";
					shell = pkgs.zsh;
					extraGroups = [ "wheel" "audio" "video" ];
				};
		};

		homeManager = {...}: {
			home.username = "steve";
			home.homeDirectory = "/home/steve";
		};
	};
}
