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

# Install JavaScript support for GraalVM 21 (standalone distribution)
RUN apt-get update -y && \
    apt-get install -y wget && \
    mkdir -p /tmp/graaljs && \
    cd /tmp/graaljs && \
    # Download and install the standalone GraalJS distribution
    wget -q https://github.com/oracle/graaljs/releases/download/graal-21.0.1/graaljs-community-21.0.1-linux-amd64.tar.gz && \
    tar -xzf graaljs-community-21.0.1-linux-amd64.tar.gz && \
    # Copy the JavaScript runtime components to GraalVM installation
    cp -rf graaljs-community-21.0.1/* $JAVA_HOME/ && \
    # Verify JavaScript is working
    echo "console.log('JavaScript test from GraalVM');" > test.js && \
    $JAVA_HOME/bin/js test.js && \
    # Cleanup
    rm -rf /tmp/graaljs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm test.js

# Create container user
RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./../entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"] 