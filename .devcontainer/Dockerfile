# -----------------------------
# Base image
# -----------------------------
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Use bash with pipefail
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# -----------------------------
# Basic OS dependencies
# -----------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    unzip \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# AWS CLI v2
# -----------------------------
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
 && unzip /tmp/awscliv2.zip -d /tmp \
 && /tmp/aws/install \
 && rm -rf /tmp/aws /tmp/awscliv2.zip

# -----------------------------
# Terraform CLI
# -----------------------------
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip -o /tmp/terraform.zip \
 && unzip /tmp/terraform.zip -d /usr/local/bin \
 && rm /tmp/terraform.zip

# -----------------------------
# Environment & user
# -----------------------------
ENV PATH="/usr/local/bin:${PATH}" \
    AWS_DEFAULT_REGION="us-west-2"
USER vscode
WORKDIR /workspace
