{ inputs, ... }:

{
	flake.aspects = { aspects, ... }: {
		dwm = {
			includes = with aspects; [ scripts dwmblocks ];

			nixos = { pkgs, ... }: {
				services = {
					displayManager = {
						defaultSession = "none+dwm"; # doesn't do anything
					};
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

				environment.systemPackages = with pkgs; [
					dmenu
					xclip
					brightnessctl
					playerctl
					xwallpaper
					imagemagick
					libnotify
					xdotool
				];

				fonts.packages = with pkgs; [
					nerd-fonts.jetbrains-mono
				];

				# Some programs need SUID wrappers, can be configured further or are
				# started in user sessions.
				/*
				programs.mtr.enable = true;
				programs.gnupg.agent = {
					enable = true;
					enableSSHSupport = true;
				};
				*/

				programs.slock.enable = true;

				programs.xss-lock = {
					enable = true;
					lockerCommand = "/run/wrappers/bin/slock";
					extraOptions = [
						"--transfer-sleep-lock"
					];
				};

				services.logind.settings.Login = {
					HandleLidSwitch = "suspend";
					HandleLidSwitchExternalPower = "suspend";
					HandleLidSwitchDocked = "suspend";

    			IdleAction = "suspend";
    			IdleActionSec = "10min";
  			};
			};

			homeManager = { config, ... }: {
				my.scripts = [ "screenshot" ];

				xsession = {
					enable = true;
					scriptPath = "${config.xdg.cacheHome}/X11/xsession"; # technically this should be a local path from $HOME
					windowManager.command = "exec dwm";
					profileExtra = ''
						# https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
						if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
							eval $(dbus-launch --exit-with-session --sh-syntax)
						fi
						systemctl --user import-environment DISPLAY XAUTHORITY
						
						if command -v dbus-update-activation-environment >/dev/null 2>&1; then
							dbus-update-activation-environment DISPLAY XAUTHORITY
						fi

						# Fix Java applications not rendering correctly on DWM
            			export _JAVA_AWT_WM_NONREPARENTING=1

						dwmblocks &
					'';
				};

				home.sessionVariables = {
					XINITRC = "${config.xdg.configHome}/X11/xinitrc";
				};

				xdg.configFile."X11/xinitrc" = {
					executable = true;
					text = ''
						export USERXSESSION="${config.xdg.cacheHome}/X11/xsession"
						$USERXSESSION
					'';
				};

				programs.zsh.enable = true;
				programs.zsh.loginExtra = ''
					if [[ "$(tty)" = "/dev/tty1" ]]; then
						pgrep dwm || startx "$XINITRC"
					fi
				'';
			};
		};
	};
}
