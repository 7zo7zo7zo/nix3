{
	flake.aspects.quake.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			ironwail
		];
	};
}
