{
	flake.aspects.nsxiv.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			nsxiv
		];
	};
}
