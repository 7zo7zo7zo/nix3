{
	flake.aspects.quakedev.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			fteqcc
			fteqw
		];
	};
}
