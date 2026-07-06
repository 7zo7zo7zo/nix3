{
	flake.aspects.steam.nixos = { pkgs, ... }: {
		programs.steam = {
			enable = true;

			extraPackages = with pkgs; [
				mangohud
			];
			
			extraCompatPackages = with pkgs; [
				proton-ge-bin
			];

			gamescopeSession.enable = true;
		};

		programs.gamemode.enable = true;
	};
}
