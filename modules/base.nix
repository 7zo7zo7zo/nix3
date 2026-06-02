{ inputs, ... }:

{
	flake.aspects.base.nixos =
		{ pkgs, ... }:
		{
			# =========================================================================
			# Bootloader
			# =========================================================================
			boot.loader = {
				efi = {
					canTouchEfiVariables = true;
					efiSysMountPoint = "/boot";
				};
				grub = {
					efiSupport = true;
					device = "nodev";
				};
			};

			# =========================================================================
			# Kernel
			# =========================================================================
			boot.kernelPackages = pkgs.linuxPackages_latest;
			#boot.kernelParams = [ ''acpi_osi="Windows 2015"'' ];

			# =========================================================================
			# Networking
			# =========================================================================
			networking.networkmanager.enable = true;

			# =========================================================================
			# Time zone
			# =========================================================================
			time.timeZone = "America/Los_Angeles";

			environment.systemPackages = with pkgs; [
				vim
				neovim
				alacritty
				htop
				file
				psmisc
				wget
				curl
				git
				tree
				fastfetch
				usbutils
				pciutils
				evtest
				zip
				unzip
				#unrar
				just
			];

			# Some programs need SUID wrappers, can be configured further or are
			# started in user sessions.
			#programs.mtr.enable = true;
			#programs.gnupg.agent = {
			#  enable = true;
			#  enableSSHSupport = true;
			#};

			# =========================================================================
			# OpenSSH
			# =========================================================================
			services.openssh.enable = true;

			# Disable askpass
			programs.ssh.enableAskPassword = false;
		};
}
