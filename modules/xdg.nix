{
	flake.aspects.xdg.homeManager = {
		xdg = {
			enable = true;
			localBinInPath = true;

			userDirs = {
				enable = true;
				setSessionVariables = true;
				createDirectories = true;
			};

			mimeApps = {
				enable = true;
				defaultApplications = {
					"application/pdf" = "org.pwmt.zathura.desktop";

					"image/bmp" = "nsxiv.desktop";
					"image/gif" = "nsxiv.desktop";
					"image/jpg" = "nsxiv.desktop";
					"image/png" = "nsxiv.desktop";
					"image/x-tga" = "nsxiv.desktop";
					"image/webp" = "nsxiv.desktop";
					"image/heic" = "nsxiv.desktop";
					"image/svg+xml" = "nsxiv.desktop";

					"video/mkv" = "mpv.desktop";
					"video/quicktime" = "mpv.desktop";
					"video/mp4" = "mpv.desktop";
					"video/webm" = "mpv.desktop";

					"inode/directory" = "nnn.desktop";
					"application/zip" = "nnn.desktop";
					"application/x-zip-compressed" = "nnn.desktop";
				};
			};
		};
	};
}
