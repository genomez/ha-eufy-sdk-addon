FROM ghcr.io/genomez/eufy-sdk-s1-amd64@sha256:3f28d98fefd9ddab0032921586f2b009e931c841e277a4ebd86a76471444f517
COPY root/ /
ENV BRIDGE_RTC_COMMAND_KEEPALIVE_MS=29000
LABEL io.hass.version="0.4.1-s1.experimental.9"
