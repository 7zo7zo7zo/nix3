{
	flake.aspects = { aspects, ... }: {
		tmux = {
			#includes = with aspects; [ dotfiles ];

			homeManager = { pkgs, ... }: {
				my.dotfiles = [ "tmux" ];

				home.packages = with pkgs; [
					tmux
				];
			};
		};
	};
}
