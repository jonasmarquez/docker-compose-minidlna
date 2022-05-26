FROM alpine:3
LABEL maintainer "Jonás Márquez jonas@jonasmarquez.com"

# Install
RUN apk --no-cache add bash curl minidlna tini shadow su-exec alpine-conf inotify-tools

# Entrypoint
COPY entrypoint.sh /
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1
