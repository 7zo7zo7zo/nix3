{
	flake.aspects.quakeworld.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			ezquake # TODO: I usually use nQuake instead
		];
	};
}
