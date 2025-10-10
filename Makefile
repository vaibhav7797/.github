.PHONY: bootstrap
bootstrap:
	@echo "🔧 Bootstrapping DevOps tools..."

	# Install pre-commit via pipx if not already installed
	@if ! command -v pre-commit >/dev/null 2>&1; then \
		echo "Installing pre-commit..."; \
		pipx install pre-commit || pip install --user pre-commit; \
	else \
		echo "pre-commit already installed"; \
	fi

	# Install commitizen via pipx if not already installed
	@if ! command -v cz >/dev/null 2>&1; then \
		echo "Installing commitizen..."; \
		pipx install commitizen || pip install --user commitizen; \
	else \
		echo "commitizen already installed"; \
	fi

	# Ensure ~/.local/bin is in PATH for this session
	@export PATH="$$HOME/.local/bin:$$PATH"

	# Install pre-commit hooks
	@pre-commit install --install-hooks
	@pre-commit install --hook-type commit-msg

	@echo "✅ Bootstrap complete. Use 'cz commit' for Conventional Commits."
