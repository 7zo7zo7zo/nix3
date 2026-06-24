{
	flake.aspects = { aspects, ... }: {
		nnn = {
			includes = with aspects; [ tmux xdg ];

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
					#libarchive
					p7zip
					bat
					glow
				];

				home.shellAliases = {
					n = "tmux new-session -- nnn -Aae -P p";
				};

				xdg.desktopEntries.nnn = {
					name = "nnn";
					genericName = "File Manager";
					exec = ''tmux new-session -- nnn -Aae -P p %f'';
					terminal = true;
					noDisplay = true;
					mimeType = [
						"inode/directory"
						"application/zip"
						"application/x-zip-compressed"
					];
					categories = [ "Utility" "FileManager" "System" "FileTools" ];
				};
			};

			home.sessionVariables = {
				NNN_ARCHIVE = "\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$";
			};
		};
	};
}
