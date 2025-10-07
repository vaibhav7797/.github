# Base image
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Use bash with pipefail for all RUN commands
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# -----------------------------
# Base OS dependencies (pinned + no-install-recommends)
# -----------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=8.3.*-1ubuntu1 \
    git=2.41.* \
    make=4.3-* \
    jq=1.6-1 \
    unzip=6.0-26ubuntu3 \
    zip=3.0-26 \
    python3=3.11.* \
    python3-pip=23.2.* \
    python3-venv=3.11.* \
    golang-go=1:1.20.* \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Terraform + TFLint + tfsec + checkov + helm + kube tools + ansible + gitleaks + trivy
# -----------------------------
RUN curl -fsSL https://raw.githubusercontent.com/antonbabenko/pre-commit-terraform/master/bin/install.sh | bash \
 && curl -fsSL https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash \
 && curl -fsSL https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash || true \
 && pip3 install --no-cache-dir \
    checkov==2.2.0 \
    commitizen==3.5.0 \
    pre-commit==3.5.2 \
    ansible==8.7.0 \
    ansible-lint==6.12.0 \
    yamllint==1.30.0 \
 && curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
 && KUBECONFORM_URL="https://github.com/yannh/kubeconform/releases/latest/download/kubeconform-linux-amd64.tar.gz" \
 && curl -fsSL "$KUBECONFORM_URL" | tar xz -C /usr/local/bin kubeconform \
 && GITLEAKS_URL="https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks_$(uname -s)_$(uname -m).tar.gz" \
 && curl -fsSL "$GITLEAKS_URL" | tar xz -C /usr/local/bin gitleaks \
 && TRIVY_URL="https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh" \
 && curl -sfL "$TRIVY_URL" | sh -s -- -b /usr/local/bin

# -----------------------------
# Hadolint
# -----------------------------
RUN HADOLINT_URL="https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-$(uname -m)" \
 && curl -sL -o /usr/local/bin/hadolint "$HADOLINT_URL" \
 && chmod +x /usr/local/bin/hadolint

# -----------------------------
# Golangci-lint
# -----------------------------
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh \
    | sh -s -- -b /usr/local/bin

# -----------------------------
# kubectl
# -----------------------------
RUN KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)" \
 && curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
 && install -m 0755 kubectl /usr/local/bin/kubectl \
 && rm kubectl
