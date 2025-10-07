.PHONY: bootstrap lint tf-validate helm-lint k8s-validate ansible-lint docker-lint py-lint go-lint

bootstrap:
	pipx install pre-commit commitizen || pip install --user pre-commit commitizen
	pre-commit install --install-hooks
	pre-commit install --hook-type commit-msg
	@echo ":white_check_mark: Installed. Use 'cz commit' for Conventional Commits."

lint:
	pre-commit run --all-files

tf-validate:
	cd terraform && terraform init -backend=false && terraform validate

helm-lint:
	helm lint charts/* || true

k8s-validate:
	kubeconform -summary -strict k8s || true

ansible-lint:
	ansible-lint ansible || true

docker-lint:
	hadolint docker/Dockerfile || true

py-lint:
	cd python && ruff check --fix . && black --check .

go-lint:
	cd go && golangci-lint run || true
