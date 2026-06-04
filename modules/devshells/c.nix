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
				# suckless
				libX11
				libXft
				libXinerama
			];
		};
	};
}
