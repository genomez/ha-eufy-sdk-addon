# Local trial runtime overlay; publication is a separate operation.
ARG BASE_IMAGE=ghcr.io/genomez/eufy-sdk-s1-amd64@sha256:3f28d98fefd9ddab0032921586f2b009e931c841e277a4ebd86a76471444f517
FROM ${BASE_IMAGE}
# Replace SDK dist as a unit; preserve the base dependency and source chain.
RUN --network=none rm -rf /app/node_modules/@mega-yfue/eufy-sdk/dist
COPY root/ /
COPY packaging/experimental6-overlay.Dockerfile /recipe/experimental6/Dockerfile
COPY packaging/EXPERIMENTAL6_OVERLAY.json /recipe/experimental6/EXPERIMENTAL6_OVERLAY.json
RUN --network=none chmod 0755 /run.sh
ENV BRIDGE_RTC_COMMAND_KEEPALIVE_MS=29000
ARG BUILD_VERSION=0.4.1-s1.experimental.6
LABEL io.hass.version="${BUILD_VERSION}"
