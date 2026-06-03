ROOT_DIR := `git rev-parse --show-toplevel`

switch HOST:
	sudo nixos-rebuild switch --flake {{ROOT_DIR}}#{{HOST}}

gc:
	sudo nix-collect-garbage --delete-old
