{ inputs, ... }:

{
	flake.aspects = { aspects, ... }: {
		dwmblocks = {
			# This is already imported in dwm.nix, multiple includes breaks because it declares options
			# includes = with aspects; [ scripts ];

			nixos = { pkgs, ... }: {
				environment.systemPackages = with pkgs; [
					(dwmblocks.overrideAttrs (_: {
						src = inputs.dwmblocks;
					}))
				];
			};

			homeManager = {
				my.scripts = [ "statusbar" ];

				home.sessionPath = [
					"$HOME/.local/bin/statusbar"
				];

			};
		};
	};
}
