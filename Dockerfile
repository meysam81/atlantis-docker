ARG ATLANTIS_VERSION="v0.30.0"

FROM ghcr.io/runatlantis/atlantis:${ATLANTIS_VERSION}

ARG TG_VERSION="0.68.4"
ARG TAC_VERSION="1.19.0"

LABEL maintainer="Meysam Azad <meysam@developer-friendly.blog>"
LABEL terragrunt_version=${TG_VERSION}
LABEL terragrunt_atlantis_config_version=${TAC_VERSION}

ARG TG_SHA256_SUM=""
ARG INIT_SHARED_DIR=/plugins
ARG TAC_SHA256_SUM=""

ENV TG_FILE="${INIT_SHARED_DIR}/terragrunt"
ENV TAC_FILE="${INIT_SHARED_DIR}/terragrunt-atlantis-config"

COPY main.sh /

USER root
RUN /main.sh && rm /main.sh
USER atlantis:atlantis
