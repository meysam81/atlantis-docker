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

TG_VERSION=${TG_VERSION#v}
TAC_VERSION=${TAC_VERSION#v}
ATLANTIS_VERSION=${ATLANTIS_VERSION#v}
TOFU_VERSION=${TOFU_VERSION#v}

wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/terragrunt_linux_${ARCH}
wget https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}
wget https://github.com/runatlantis/atlantis/releases/download/v${ATLANTIS_VERSION}/atlantis_linux_${ARCH}.zip
wget https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_linux_${ARCH}.tar.gz

if [ -z "${TG_SHA256_SUM}"]; then
    TG_SHA256_SUM=$(wget -qO- https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/SHA256SUMS | grep "terragrunt_linux_${ARCH}" | awk '{print $1}')
fi

if [ -z "${TAC_SHA256_SUM}"]; then
    TAC_SHA256_SUM=$(wget -qO- https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/SHA256SUMS | grep "terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}" | awk '{print $1}')
fi

if [ -z "${ATLANTIS_SHA256_SUM}"]; then
    ATLANTIS_SHA256_SUM=$(wget -qO- https://github.com/runatlantis/atlantis/releases/download/v${ATLANTIS_VERSION}/checksums.txt | grep "atlantis_linux_${ARCH}.zip" | awk '{print $1}')
fi

if [ -z "${TOFU_SHA256_SUM}"]; then
    TOFU_SHA256_SUM=$(wget -qO- https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_SHA256SUMS | grep "tofu_${TOFU_VERSION}_linux_${ARCH}.tar.gz" | awk '{print $1}')
fi

echo "${TG_SHA256_SUM} terragrunt_linux_${ARCH}" | sha256sum -c
mv "terragrunt_linux_${ARCH}" /usr/local/bin/terragrunt
chmod 755 /usr/local/bin/terragrunt
terragrunt -v

echo "${TAC_SHA256_SUM} terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}" | sha256sum -c
mv "terragrunt-atlantis-config_${TAC_VERSION}_linux_${ARCH}" /usr/local/bin/terragrunt-atlantis-config
chmod 755 /usr/local/bin/terragrunt-atlantis-config
terragrunt-atlantis-config version

echo "${ATLANTIS_SHA256_SUM} atlantis_linux_${ARCH}.zip" | sha256sum -c
unzip "atlantis_linux_${ARCH}.zip"
mv atlantis /usr/local/bin/atlantis
chmod 755 /usr/local/bin/atlantis
atlantis version

echo "${TOFU_SHA256_SUM} tofu_${TOFU_VERSION}_linux_${ARCH}.tar.gz" | sha256sum -c
tar -xvf "tofu_${TOFU_VERSION}_linux_${ARCH}.tar.gz"
mv tofu /usr/local/bin/tofu
chmod 755 /usr/local/bin/tofu
tofu -version
