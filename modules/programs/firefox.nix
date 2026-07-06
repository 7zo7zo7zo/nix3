{
	flake.aspects.firefox.nixos = {
		programs.firefox = {
			enable = true;
			preferences = {
				# Disable sponsored content and pocket
				"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
				"browser.newtabpage.activity-stream.showSponsored"            = false;
				"browser.newtabpage.activity-stream.showSponsoredTopSites"    = false;
				# Disable telemetry
				"datareporting.healthreport.uploadEnabled"                    = false;
				"datareporting.policy.dataSubmissionEnabled"                  = false;
				"toolkit.telemetry.enabled"                                   = false;
				"toolkit.telemetry.unified"                                   = false;
			};
			policies = {
				# -----------------------------------------------------------------------
				# Disable Firefox features we don't want
				# -----------------------------------------------------------------------
				DisableTelemetry        = true;
				DisableFirefoxStudies   = true;
				DisablePocket           = true;        # Remove Pocket integration
				DisableFirefoxAccounts  = true;       # Disable FF accounts
				DontCheckDefaultBrowser = true;
				DisableFormHistory      = false;       # Keep form history — convenience
				# -----------------------------------------------------------------------
				# Force install extensions + uBlock Origin configuration
				#
				# Extensions listed here are installed automatically for ALL users
				# and cannot be removed by the user.
				# The "3rdparty" key pushes default settings to extensions.
				# -----------------------------------------------------------------------
				ExtensionSettings = {
					# uBlock Origin — forced install, cannot be removed
					"uBlock0@raymondhill.net" = {
						installation_mode = "force_installed";
						install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
					};
					# SponsorBlock
					"sponsorBlocker@ajay.app" = {
						installation_mode = "normal_installed";
						install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
					};
					# Ctrl+Number to switch tabs
					"{84601290-bec9-494a-b11c-1baa897a9683}" = {
						installation_mode = "normal_installed";
						install_url = "https://addons.mozilla.org/firefox/downloads/latest/ctrl-number-to-switch-tabs/latest.xpi";
					};
					# Violentmonkey
					"{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
						installation_mode = "normal_installed";
						install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
					};
					# Push default configuration to uBlock Origin for all users.
					# Enables our custom Shorts filter alongside standard filter lists.
					"3rdparty" = {
						Extensions = {
							"uBlock0@raymondhill.net" = {
								adminSettings = {
									userSettings = {
										uiTheme            = "dark";
										showIconBadge      = true;
										alwaysDetachLogger = false;
									};
									selectedFilterLists = [
										"ublock-filters"      # uBlock Origin built-in filters
										"ublock-badware"      # Malware protection
										"ublock-privacy"      # Privacy protection
										"ublock-unbreak"      # Fix broken sites after filtering
										"easylist"            # Standard ad blocking
										"easyprivacy"         # Tracking protection
										"urlhaus-1"           # Malicious URL blocking
									];
									#userFilters = uBlockCustomFilters;
								};
							};
						};
					};
				};
			};
		};
	};
}
