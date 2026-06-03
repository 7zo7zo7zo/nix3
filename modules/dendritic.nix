{ inputs, ... }:

{
	imports = [
		inputs.flake-parts.flakeModules.modules
		inputs.flake-aspects.flakeModule
	];
}
