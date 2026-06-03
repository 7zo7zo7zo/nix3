{
	flake.aspects.office.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			libreoffice
			hunspell
			hunspellDicts.en-us
		];
	};
}
