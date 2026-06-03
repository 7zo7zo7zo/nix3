{ inputs, ... }:

{
	flake.aspects = { aspects, ... }: {
		dwm = {
			includes = with aspects; [ scripts dwmblocks ];

			nixos = { pkgs, ... }: {
				services = {
					xserver = {
						enable = true;
						autoRepeatDelay = 200;
						autoRepeatInterval = 35;
						displayManager = {
							startx.enable = true;
						};
						windowManager.dwm = {
							enable = true;
							package = pkgs.dwm.overrideAttrs {
								src = inputs.dwm;
							};
						};
					};
					picom.enable = true;
					dunst.enable = true;
				};

				environment.localBinInPath = true;

				environment.systemPackages = with pkgs; [
					dmenu
					xclip
					brightnessctl
					playerctl
					xwallpaper
					imagemagick
					libnotify
					xdotool
					pavucontrol
				];

				fonts.packages = with pkgs; [
					nerd-fonts.jetbrains-mono
				];
			};

			homeManager = { config, ... }: {
				my.scripts = [ "screenshot" ];

				home.sessionVariables = {
					XINITRC = "${config.xdg.configHome}/X11/xinitrc";
				};

				xdg.configFile."X11/xinitrc" = {
					executable = true;
					text = ''
						# https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
						if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
							eval $(dbus-launch --exit-with-session --sh-syntax)
						fi
							systemctl --user import-environment DISPLAY XAUTHORITY

						if command -v dbus-update-activation-environment >/dev/null 2>&1; then
							dbus-update-activation-environment DISPLAY XAUTHORITY
						fi

						dwmblocks &
						exec dwm
					'';
				};

				programs.zsh.enable = true;
				programs.zsh.profileExtra = ''
					if [[ "$(tty)" = "/dev/tty1" ]]; then
						pgrep dwm || startx "$XINITRC"
					fi
				'';
			};
		};
	};
}
