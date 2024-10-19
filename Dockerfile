ARG ATLANTIS_VERSION="v0.30.0"

FROM ghcr.io/runatlantis/atlantis:${ATLANTIS_VERSION}

ARG TG_VERSION="v0.68.4"
ARG TG_SHA256_SUM="ae9a1172f32cf69a7db4762376acb2264a1dd4712e38c53fbc050854acc377b0"
ARG INIT_SHARED_DIR=/plugins
ARG TAC_VERSION="1.19.0" # without v
ARG TAC_SHA256_SUM="5891bd8fe40fd41c9a14bc8d82ea60ebfb75ebe91680f84b74f9538af52f78b0"

ENV TG_FILE="${INIT_SHARED_DIR}/terragrunt"
ENV TAC_FILE="${INIT_SHARED_DIR}/terragrunt-atlantis-config"

RUN if [ "$(uname -m)" = "aarch64" ]; then && \
      wget https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_arm64 -O "${TG_FILE}"  && \
      wget "https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/terragrunt-atlantis-config_${TAC_VERSION}_linux_arm64" && \
    else  && \
      wget https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_amd64 -O "${TG_FILE}"  && \
      wget "https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TAC_VERSION}/terragrunt-atlantis-config_${TAC_VERSION}_linux_amd64" && \
    fi  && \
    echo "${TG_SHA256_SUM}  ${TG_FILE}" | sha256sum -c  && \
    chmod 755 "${TG_FILE}"  && \
    terragrunt -v && \
    echo "${TAC_SHA256_SUM}  terragrunt-atlantis-config_${TAC_VERSION}_linux_arm64" | sha256sum -c && \
    cp -fv "terragrunt-atlantis-config_${TAC_VERSION}_linux_arm64" "${TAC_FILE}" && \
    chmod 755 "${TAC_FILE}" && \
    terragrunt-atlantis-config version
