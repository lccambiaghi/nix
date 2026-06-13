.DEFAULT_GOAL := help

.PHONY: help
help: ## Show all available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# Pick the flake config matching the current machine's hostname (mbp, brc, ...)
HOST := $(shell hostname -s)

.PHONY: reload
reload: ## Rebuild the configuration for the current host (auto-detected from hostname)
	sudo darwin-rebuild switch --flake .#$(HOST)

.PHONY: update
update: ## Update nixpkgs inputs
	nix flake update

.PHONY: link-devcontainer
link-devcontainer: ## Symlink a project's .devcontainer to the shared one. Usage: make link-devcontainer DIR=~/git/Foo
	@test -n "$(DIR)" || { echo "Usage: make link-devcontainer DIR=<project path>"; exit 1; }
	@proj=$$(python3 -c "import os;print(os.path.realpath(os.path.expanduser('$(DIR)')))"); \
	test -d "$$proj" || { echo "No such directory: $$proj"; exit 1; }; \
	if [ -e "$$proj/.devcontainer" ] && [ ! -L "$$proj/.devcontainer" ]; then \
	  echo "$$proj/.devcontainer exists and is not a symlink — remove or back it up first."; exit 1; fi; \
	rel=$$(python3 -c "import os;print(os.path.relpath('$(CURDIR)/devcontainer', '$$proj'))"); \
	ln -sfn "$$rel" "$$proj/.devcontainer"; \
	echo "Linked $$proj/.devcontainer -> $$rel"

.PHONY: rebind
rebind: ## Swap backtick and the ISO section key (Italian keyboard, mbp)
	/usr/bin/hidutil property --set '{"UserKeyMapping":[ \
        {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}, \
        {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035} \
      ]}'
