# Pterodactyl Core Dockerfile
# env java
# Minimum Panel Version: 1.7.0
# Person98

FROM ubuntu:22.04

LABEL author="Person98"

ARG GRAALVM_VERSION=21.0.2
ARG POLYGLOT_VERSION=23.1.2

ENV DEBIAN_FRONTEND=noninteractive
# Default to UTF-8 file.encoding
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Install necessary packages
RUN apt-get update -y \
    && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata locales iproute2 unzip \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    # Download and install GraalVM
    && mkdir -p /opt/java \
    && cd /opt/java \
    && curl -L -o graalvm.tar.gz https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${GRAALVM_VERSION}/graalvm-community-jdk-${GRAALVM_VERSION}_linux-x64_bin.tar.gz \
    && tar -xzf graalvm.tar.gz \
    && mv graalvm-* graalvm \
    && rm graalvm.tar.gz \
    # Download and install GraalVM Polyglot libraries
    && mkdir -p /opt/java/graalvm/lib/polyglot \
    && cd /opt/java/graalvm/lib/polyglot \
    # Download polyglot library
    && curl -L -o polyglot.jar https://repo1.maven.org/maven2/org/graalvm/polyglot/polyglot/${POLYGLOT_VERSION}/polyglot-${POLYGLOT_VERSION}.jar \
    # Download js library
    && curl -L -o js.jar https://repo1.maven.org/maven2/org/graalvm/polyglot/js-community/${POLYGLOT_VERSION}/js-community-${POLYGLOT_VERSION}.jar \
    # Remove apt lists
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/opt/java/graalvm \
    PATH="/opt/java/graalvm/bin:$PATH" \
    CLASSPATH="/opt/java/graalvm/lib/polyglot/*"

# Create container user
RUN useradd -d /home/container -m container \
    # Copy the polyglot jars to the plugins folder so they're accessible to the plugin classpath
    && mkdir -p /home/container/plugins \
    && cp /opt/java/graalvm/lib/polyglot/*.jar /home/container/plugins/ \
    && chown -R container:container /home/container/plugins

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container
COPY ./../entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"] 