# Pterodactyl Core Dockerfile
# env java
# Minimum Panel Version: 1.7.0
# Person98

# Using official GraalVM community container image
FROM ghcr.io/graalvm/jdk-community:21.0.1

LABEL author="Person98"

ENV DEBIAN_FRONTEND=noninteractive

# Default to UTF-8 file.encoding
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Install necessary packages and JavaScript support
RUN apt-get update -y \
    && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata locales iproute2 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    # Download and install JavaScript standalone runtime
    && cd /tmp \
    && curl -L -o js.tar.gz https://github.com/oracle/graaljs/releases/download/vm-23.1.1/graaljs-community-23.1.1-linux-amd64.tar.gz \
    && mkdir -p /opt/graaljs \
    && tar -xzf js.tar.gz -C /opt/graaljs --strip-components=1 \
    && ln -s /opt/graaljs/bin/js /usr/local/bin/js \
    && rm -rf /tmp/js.tar.gz \
    && rm -rf /var/lib/apt/lists/*

# Create container user
RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container
COPY ./../entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"] 