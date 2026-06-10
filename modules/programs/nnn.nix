{
	flake.aspects = { aspects, ... }: {
		nnn = {
			includes = with aspects; [ tmux ];

			homeManager = { pkgs, lib, ... }: {
				programs.nnn = {
					enable = true;
					package = pkgs.nnn.override {
						withNerdIcons = true;
					};
					plugins = {
						src = (pkgs.fetchFromGitHub {
							owner = "jarun";
							repo = "nnn";
							rev = "v5.2";
							sha256 = "sha256-u+88aDHfOZ6bSkg6ahS6eNZWj2QCwJXKW+8nHR99kic=";
						}) + "/plugins";
						mappings = {
							p = "preview-tui";
							d = "dragdrop";
						};
					};
				};

				home.packages = with pkgs; [
					dragon-drop
					ueberzugpp
					ffmpegthumbnailer
					poppler-utils
					atool
				];

				home.shellAliases = {
					n = ''tmux new-session "nnn -Aa -P p ~"'';
				};
			};
		};
	};
}
