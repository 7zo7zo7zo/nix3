{
	flake.aspects.dotfiles.homeManager = { config, lib, ...}: let
		dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
		create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	in {
		options.my.dotfiles = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [];
			description = "list of config directories to symlink";
		};

		config.xdg.configFile = builtins.listToAttrs (map (name: {
			inherit name;
			value.source = create_symlink "${dotfiles}/${name}";
		}) config.my.dotfiles);
	};
}
