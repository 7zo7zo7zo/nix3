{
	flake.aspects.doom.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			dsda-doom
		];
	};
}
