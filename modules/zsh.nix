{
	flake.aspects.zsh.homeManager = { pkgs, config, ... }: {
		programs.zsh = {
			enable = true;
			dotDir = "${config.xdg.configHome}/zsh";
			history = {
				path = "${config.xdg.stateHome}/zsh/history";
				size = 10000;
				save = 10000;
			};
			plugins = [
				{
					name = "fast-syntax-highlighting";
					src  = pkgs.zsh-fast-syntax-highlighting;
					file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
				}
			];
			shellAliases = {
				nrs = "sudo nixos-rebuild switch --flake";
			};
			enableCompletion = false;
			initContent = ''
				autoload -U colors && colors

				autoload -U compinit
				zstyle ':completion:*' menu select
				zstyle ':completion:*:make:*:targets' call-command true
				zstyle ':completion:*:*:make:*' tag-order 'targets'
				zmodload zsh/complist
				compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
				_comp_options+=(globdots) # Include hidden files in tab completion

				setopt prompt_subst
				autoload -Uz vcs_info
				zstyle ':vcs_info:git:*' formats ' (%b)'
				precmd() { vcs_info }

				stty stop undef # Stop Ctrl+S from freezing the terminal

				bindkey -e

				PROMPT='%F{green}%n@%m%f:%F{cyan}%1~%f%F{yellow}''${vcs_info_msg_0_} %f> '
			'';
		};
		home.sessionVariables = {
			BROWSER = "firefox";
			EDITOR = "nvim";
		};
		xdg.cacheFile."zsh/.keep".text = "";
	};
}

