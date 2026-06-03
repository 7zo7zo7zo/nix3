{ inputs, ... }:

{
  imports = [
		inputs.flake-parts.flakeModules.modules
		inputs.flake-aspects.flakeModule
		#inputs.home-manager.flakeModules.home-manager
	];
}
