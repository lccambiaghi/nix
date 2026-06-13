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

.PHONY: rebind
rebind: ## Swap backtick and the ISO section key (Italian keyboard, mbp)
	/usr/bin/hidutil property --set '{"UserKeyMapping":[ \
        {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}, \
        {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035} \
      ]}'
