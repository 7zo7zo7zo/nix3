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
					"arch" = {
						id = "WPHMAJJ-JDMRUZS-366RC5N-P4TR2ES-YXNDBXU-L7FB57I-2XWB6QP-ZBDGOQF";
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
							"arch"
							"iPhone"
						];
					};
				};
			};
		};
	};
}
