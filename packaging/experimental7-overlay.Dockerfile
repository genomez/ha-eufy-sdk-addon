ARG BASE_IMAGE=ghcr.io/genomez/eufy-sdk-s1-amd64@sha256:3f28d98fefd9ddab0032921586f2b009e931c841e277a4ebd86a76471444f517
FROM ${BASE_IMAGE}
RUN --network=none rm -rf /app/node_modules/@mega-yfue/eufy-sdk/dist
COPY root/ /
COPY packaging/experimental7-overlay.Dockerfile /recipe/experimental7/Dockerfile
COPY packaging/EXPERIMENTAL7_OVERLAY.json /recipe/experimental7/EXPERIMENTAL7_OVERLAY.json
RUN --network=none chmod 0755 /run.sh
ENV BRIDGE_RTC_COMMAND_KEEPALIVE_MS=29000
ARG BUILD_VERSION=0.4.1-s1.experimental.7
LABEL io.hass.version="${BUILD_VERSION}"
