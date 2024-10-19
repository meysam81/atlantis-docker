ARG ATLANTIS_VERSION="v0.30.0"

FROM ghcr.io/runatlantis/atlantis:${ATLANTIS_VERSION}

ARG TG_VERSION="v0.68.4"
ARG TG_SHA256_SUM="ae9a1172f32cf69a7db4762376acb2264a1dd4712e38c53fbc050854acc377b0"
ARG INIT_SHARED_DIR=/plugins
ARG TAC_VERSION="1.19.0" # without v
ARG TAC_SHA256_SUM="5891bd8fe40fd41c9a14bc8d82ea60ebfb75ebe91680f84b74f9538af52f78b0"

ENV TG_FILE="${INIT_SHARED_DIR}/terragrunt"
ENV TAC_FILE="${INIT_SHARED_DIR}/terragrunt-atlantis-config"

COPY main.sh /

USER root
RUN /main.sh && rm /main.sh
USER atlantis:atlantis
