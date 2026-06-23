{
	flake.aspects = { aspects, ... }: {
		fastfetch = {
			#includes = with aspects; [ dotfiles ];

			homeManager = { pkgs, ... }: {
				my.dotfiles = [ "fastfetch" ];

				home.packages = with pkgs; [
					fastfetch
				];
			};
		};
	};
}
