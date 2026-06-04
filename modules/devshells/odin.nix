{
	perSystem = { pkgs, ... }: {
		devShells.odin = pkgs.mkShell {
			packages = with pkgs; [
				odin
			];
		};
	};
}
