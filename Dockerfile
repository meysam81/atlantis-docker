
FROM curlimages/curl AS bins

ARG ATLANTIS_VERSION="v0.30.0"
ARG TG_VERSION="0.68.4"
ARG TAC_VERSION="1.19.0"
ARG TOFU_VERSION="1.8.5"

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

FROM gcr.io/distroless/base-nossl-debian12:nonroot

COPY --from=bins /usr/local/bin/atlantis /usr/local/bin/atlantis
COPY --from=bins /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=bins /usr/local/bin/terragrunt /usr/local/bin/terragrunt
COPY --from=bins /usr/local/bin/terragrunt-atlantis-config /usr/local/bin/terragrunt-atlantis-config

CMD ["/usr/local/bin/atlantis", "server"]
