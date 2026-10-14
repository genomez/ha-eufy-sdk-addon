# Private amd64 recipe. Prepare the allowlisted context before invoking a build.
FROM --platform=linux/amd64 node@sha256:d6aa754f16b3197301076f047b5def2f02ea1dbbc2ca920407d46d7ec7f87b20 AS os-inputs
COPY packaging/image-inputs.lock.json packaging/fetch-os.mjs /recipe/
RUN node /recipe/fetch-os.mjs /os-debs

FROM --platform=linux/amd64 node@sha256:d6aa754f16b3197301076f047b5def2f02ea1dbbc2ca920407d46d7ec7f87b20 AS dependencies
WORKDIR /app
COPY pair/package.json pair/package-lock.json ./
COPY artifacts/eufy-sdk-local.tgz /artifacts/eufy-sdk-local.tgz
COPY packaging/image-inputs.lock.json packaging/verify-inputs.mjs /recipe/
ENV NPM_CONFIG_USERCONFIG=/tmp/empty-user.npmrc \
    NPM_CONFIG_GLOBALCONFIG=/tmp/empty-global.npmrc \
    NPM_CONFIG_REGISTRY=https://registry.npmjs.org/ \
    NPM_CONFIG_AUDIT=false NPM_CONFIG_FUND=false
RUN node /recipe/verify-inputs.mjs pair \
 && npm ci --omit=dev --include=optional --ignore-scripts --no-audit --no-fund \
 && node /recipe/verify-inputs.mjs sdk

FROM --platform=linux/amd64 node@sha256:d6aa754f16b3197301076f047b5def2f02ea1dbbc2ca920407d46d7ec7f87b20 AS runtime
ARG BUILD_ARCH=amd64
ARG BUILD_VERSION=0.4.0-s1.1
LABEL io.hass.type="app" io.hass.arch="amd64" io.hass.version="${BUILD_VERSION}"
COPY packaging/image-inputs.lock.json packaging/verify-inputs.mjs /recipe/
# Only previously verified local packages are visible to this network-disabled installation.
RUN --network=none --mount=type=bind,from=os-inputs,source=/os-debs,target=/os-debs \
    test "$BUILD_ARCH" = amd64 \
 && test "$(dpkg --print-architecture)" = amd64 \
 && node /recipe/verify-inputs.mjs debs \
 && DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install /os-debs/*.deb \
 && node /recipe/verify-inputs.mjs os
WORKDIR /app
COPY --from=dependencies /app/node_modules /app/node_modules
COPY pair/package.json /app/package.json
COPY bridge/ /app/
COPY run.sh /run.sh
COPY packaging/native-check.mjs packaging/media-check.mjs /app/packaging/
COPY artifacts/go2rtc_linux_amd64 /usr/local/bin/go2rtc
COPY licenses/ /usr/share/licenses/eufy/
COPY LICENSE /usr/share/licenses/eufy/addon-LICENSE
RUN --network=none node /recipe/verify-inputs.mjs sdk \
 && node /recipe/verify-inputs.mjs go2rtc \
 && chmod 0755 /run.sh /app/bin/start.sh /usr/local/bin/go2rtc \
 && ln -s /app/bin/start.sh /usr/local/bin/eufy-sdk-bridge \
 && mkdir -p /data \
 && chmod 0700 /data \
 && node /app/packaging/native-check.mjs \
 && node /app/packaging/media-check.mjs
ENV BRIDGE_APP_DIR=/app BRIDGE_PORT=3000 BRIDGE_HOST=0.0.0.0 \
    EUFY_SESSION=/data/.eufy-session.json GO2RTC_CONFIG=/data/go2rtc.yaml \
    BRIDGE_RTC_SESSION_REFRESH_MS=270000 BRIDGE_T9000_MEDIA_DIAGNOSTICS=1
EXPOSE 3000/tcp 1984/tcp 8554/tcp 8555/udp
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/run.sh"]
