# Pterodactyl Core Dockerfile
# env java
# Minimum Panel Version: 1.7.0
# Person98

# Using official GraalVM Community container image
FROM ghcr.io/graalvm/graalvm-community:21.0.2

LABEL author="Person98"

ENV DEBIAN_FRONTEND=noninteractive
# Default to UTF-8 file.encoding
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Install necessary packages
RUN microdnf update -y \
    && microdnf install -y curl ca-certificates openssl git tar sqlite fontconfig tzdata langpacks-en glibc-langpack-en iproute \
    && microdnf clean all

# Create container user
RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container
COPY ./../entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"] 