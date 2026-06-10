{
	flake.aspects.zathura.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			zathura
		];
	};
}
