.PHONY: bootstrap
bootstrap:
	pipx install pre-commit commitizen || pip install --user pre-commit commitizen
	pre-commit install --install-hooks
	pre-commit install --hook-type commit-msg
	@echo ":white_check_mark: Installed. Use 'cz commit' for Conventional Commits."
