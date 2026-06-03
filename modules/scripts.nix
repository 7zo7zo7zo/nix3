{
	flake.aspects.scripts.homeManager = { config, lib, ... }: let
		scriptsRoot = "${config.home.homeDirectory}/nc2/scripts";
		create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	in {
		options.my.scripts = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [];
			description = "Directories or files under scriptsRoot to symlink into ~/.local/bin";
		};

		config.home.file = builtins.listToAttrs (map (name: {
			name = ".local/bin/${name}";
			value.source = create_symlink "${scriptsRoot}/${name}";
		}) config.my.scripts);
	};
}
