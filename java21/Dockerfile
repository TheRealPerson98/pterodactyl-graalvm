# Pterodactyl Core Dockerfile
# env java
# Minimum Panel Version: 1.7.0
# Person98

FROM ubuntu:22.04

LABEL author="Person98"

ARG GRAAL_VERSION=23.0.1
ARG JAVA_VERSION=21.0.1

ENV DEBIAN_FRONTEND=noninteractive

# Default to UTF-8 file.encoding
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update -y \
    && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata locales iproute2 \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && curl --retry 3 -Lfso /tmp/graalvm.tar.gz https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-21.0.1/graalvm-community-jdk-21.0.1_linux-x64_bin.tar.gz \
    && mkdir -p /opt/java/graalvm \
    && cd /opt/java/graalvm \
    && tar -xf /tmp/graalvm.tar.gz --strip-components=1 \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/graalvm.tar.gz

ENV JAVA_HOME=/opt/java/graalvm \
    PATH="/opt/java/graalvm/bin:$PATH"

# Install standalone Node.js distribution for GraalVM 21
RUN apt-get update -y && \
    apt-get install -y wget && \
    # Download the Node.js standalone distribution
    wget -q -O /tmp/graalnodejs.tar.gz https://github.com/oracle/graaljs/releases/download/graal-24.0.2/graalnodejs-community-24.0.2-linux-amd64.tar.gz && \
    # Extract it to a temporary location
    mkdir -p /tmp/graalnodejs && \
    tar -xzf /tmp/graalnodejs.tar.gz -C /tmp/graalnodejs --strip-components=1 && \
    # Copy the Node.js binaries to the GraalVM installation
    cp -R /tmp/graalnodejs/bin/* $JAVA_HOME/bin/ && \
    cp -R /tmp/graalnodejs/lib/* $JAVA_HOME/lib/ && \
    # Cleanup
    rm -rf /tmp/graalnodejs /tmp/graalnodejs.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create container user
RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"] 