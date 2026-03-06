# Redsocks docker image.
FROM debian:bookworm-slim

LABEL maintainer="Anoncheg1 <https://github.com/Anoncheg1>"

# Set environment
ENV DEBIAN_FRONTEND=noninteractive \
    DOCKER_NET=docker0

# Install redsocks and iptables, clean in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends redsocks iptables && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy files
COPY redsocks.tmpl /etc/redsocks.tmpl
COPY whitelist.txt /etc/redsocks-whitelist.txt
COPY redsocks.sh /usr/local/bin/
COPY redsocks-fw.sh /usr/local/bin/

# Set permissions
RUN chmod +x /usr/local/bin/*

# Switch to non-root user
USER redsocks

# Entry point
ENTRYPOINT ["/usr/local/bin/redsocks.sh"]
