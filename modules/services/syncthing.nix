{
	flake.aspects.syncthing.nixos = {
		services.syncthing = {
			enable = true;
			openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
			guiAddress = "127.0.0.1:8384";
			user = "steve";
			group = "users";
			dataDir = "/home/steve";
			configDir = "/home/steve/.config/syncthing";

			overrideDevices = true;
			overrideFolders = true;

			settings = {
				devices = {
					"nitro" = {
						id = "XVGBHF4-EDVRXW5-UTD2DKW-HXSEC3T-6HB5UAX-XEAKUHA-JDSEA6N-SZHKMQP";
					};
					"lenovo" = {
						id = "5TTQ4I2-THG3OX2-XQ6KXTO-DF4DUQK-2FZNVG4-FSY7E35-AGMMPWL-KE3NNQD";
					};
					"iPhone" = {
						id = "AWNG5TD-BELRLW2-6NRMZSD-WLITHLK-3P55C5Q-CFJDFDX-MP7WO6D-IF52IAC";
					};
				};

				folders = {
					"hcqkg-6rq2h" = {
						label = "Obsidian";
						path = "/home/steve/Documents/Obsidian";
						devices = [
							"nitro"
							"lenovo"
							"iPhone"
						];
					};
				};
			};
		};
	};
}
