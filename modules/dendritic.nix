{ inputs, ... }:

{
	imports = [
		inputs.flake-parts.flakeModules.modules
		inputs.flake-aspects.flakeModule
	];

	systems = [
		"x86_64-linux"
	];
}
