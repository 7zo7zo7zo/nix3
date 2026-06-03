{
	flake.aspects.mpv.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			mpv
		];
	};
}
