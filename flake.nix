{
	description = "My NixOS/home-manager configurations";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		flake-parts = {
			url = "github:hercules-ci/flake-parts";
			inputs.nixpkgs-lib.follows = "nixpkgs";
		};

		import-tree.url = "github:vic/import-tree";

		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		dwm = {
			url = "github:7zo7zo7zo/dwm-temp";
			flake = false;
		};
		st = {
			url = "github:7zo7zo7zo/st-temp";
			flake = false;
		};
		dwmblocks = {
			url = "github:7zo7zo7zo/dwmblocks";
			flake = false;
		};
	};

	outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}



