{ inputs, ... }:

{
	flake.aspects.st.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			(pkgs.st.overrideAttrs (_: {
				src = inputs.st;
			}))
		];
	};
}
