#!/usr/bin/env sh

set -eux

if [ "$(uname -m)" = "aarch64" ]; then
    ARCH="arm64"
elif [ "$(uname -m)" = "x86_64" ]; then
    ARCH="amd64"
else
    echo "Unsupported architecture"
    exit 1
fi

wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/terragrunt_linux_${ARCH}
wget "https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}"

if [ -z "${TG_SHA256_SUM}"]; then
    TG_SHA256_SUM=$(wget -qO- https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/SHA256SUMS | grep "terragrunt_linux_${ARCH}" | awk '{print $1}')
fi

if [ -z "${TAC_SHA256_SUM}"]; then
    TAC_SHA256_SUM=$(wget -qO- https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/SHA256SUMS | grep "terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}" | awk '{print $1}')
fi

echo "${TG_SHA256_SUM} terragrunt_linux_${ARCH}" | sha256sum -c
mv "terragrunt_linux_${ARCH}" /usr/local/bin/terragrunt
chmod 755 /usr/local/bin/terragrunt
terragrunt -v

echo "${TAC_SHA256_SUM}  terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}" | sha256sum -c
mv "terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}" /usr/local/bin/terragrunt-atlantis-config
chmod 755 /usr/local/bin/terragrunt-atlantis-config
terragrunt-atlantis-config version
