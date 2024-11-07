ARG ATLANTIS_VERSION="v0.30.0"

FROM ghcr.io/runatlantis/atlantis:${ATLANTIS_VERSION}

ARG TG_VERSION="0.68.4"
ARG TAC_VERSION="1.19.0"

LABEL maintainer="Meysam Azad <meysam@developer-friendly.blog>"
LABEL terragrunt_version=${TG_VERSION}
LABEL terragrunt_atlantis_config_version=${TAC_VERSION}

ARG TG_SHA256_SUM=""
ARG TAC_SHA256_SUM=""

COPY main.sh /

USER root
RUN apk update && \
    apk upgrade && \
    rm -rf /var/cache/apk/* && \
    /main.sh && \
    rm /main.sh
USER atlantis:atlantis
