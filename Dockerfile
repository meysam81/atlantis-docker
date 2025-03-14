FROM curlimages/curl AS bins

ARG ATLANTIS_VERSION="v0.33.0"
ARG TG_VERSION="0.75.10"
ARG TAC_VERSION="1.20.0"
ARG TOFU_VERSION="1.9.0"

ARG TG_SHA256_SUM=""
ARG TAC_SHA256_SUM=""
ARG ATLANTIS_SHA256_SUM=""
ARG TOFU_SHA256_SUM=""

LABEL maintainer="Meysam Azad <meysam@developer-friendly.blog>"
LABEL atlantis_version=${ATLANTIS_VERSION}
LABEL terragrunt_atlantis_config_version=${TAC_VERSION}
LABEL terragrunt_version=${TG_VERSION}

USER root

COPY main.sh /

RUN /main.sh && \
    rm /main.sh

FROM debian:12-slim AS git-deps
RUN apt-get update && \
    apt-get install -y git && \
    mkdir -p /git-deps && \
    cp $(which git) /git-deps/ && \
    ldd $(which git) | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' /git-deps/ && \
    cp -r /usr/lib/git-core /git-deps/

FROM gcr.io/distroless/base-nossl-debian12:nonroot

COPY --from=bins /usr/local/bin/atlantis /usr/local/bin/atlantis
COPY --from=bins /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=bins /usr/local/bin/terragrunt /usr/local/bin/terragrunt
COPY --from=bins /usr/local/bin/terragrunt-atlantis-config /usr/local/bin/terragrunt-atlantis-config

COPY --from=git-deps /git-deps/* /usr/lib/
COPY --from=git-deps /git-deps/git-core /usr/lib/git-core

ENV PATH="/usr/lib:${PATH}"


CMD ["/usr/local/bin/atlantis", "server"]
