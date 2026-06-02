{
	flake.aspects.printing.nixos = {
		# Enable CUPS to print documents.
		services.printing.enable = true;
	};
}

