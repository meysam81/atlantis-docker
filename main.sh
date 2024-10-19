#!/usr/bin/env sh

set -eux

mkdir -p ${INIT_SHARED_DIR}

if [ "$(uname -m)" = "aarch64" ]; then
    wget https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_arm64 -O "${TG_FILE}"
    wget "https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/terragrunt-atlantis-config_${TAC_VERSION}_linux_arm64"
else
    wget https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_amd64 -O "${TG_FILE}"
    wget "https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/terragrunt-atlantis-config_${TAC_VERSION}_linux_amd64"
fi

echo "${TG_SHA256_SUM}  ${TG_FILE}" | sha256sum -c
chmod 755 "${TG_FILE}"
terragrunt -v

echo "${TAC_SHA256_SUM}  terragrunt-atlantis-config_${TAC_VERSION}_linux_arm64" | sha256sum -c
cp -fv "terragrunt-atlantis-config_${TAC_VERSION}_linux_arm64" "${TAC_FILE}"
chmod 755 "${TAC_FILE}"

terragrunt-atlantis-config version
