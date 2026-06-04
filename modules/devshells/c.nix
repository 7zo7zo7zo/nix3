{
	perSystem = { pkgs, ... }: {
		devShells.c = pkgs.mkShell {
			packages = with pkgs; [
				clang-tools
				cppcheck
				gcc
				gnumake
				cmake
			];

			buildInputs = with pkgs; [
				xorg.libX11
				xorg.libXft
				xorg.libXinerama
			];
		};
	};
}
