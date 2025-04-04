FROM ubuntu:24.04

ARG TARGETPLATFORM
ARG GRAAL_VERSION=21.3.3
ARG JAVA_VERSION=21

    
ENV DEBIAN_FRONTEND=noninteractive
    
# Default to UTF-8 file.encoding
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
    
RUN apt-get update -y \
  && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata locales iproute2 \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.UTF-8 \
  && case ${TARGETPLATFORM} in \
         "linux/amd64")  ARCH=x64  ;; \
         "linux/arm64")  ARCH=aarch64  ;; \
    esac \
  && curl --retry 3 -Lfso /tmp/graalvm.tar.gz https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-java${JAVA_VERSION}-linux-${ARCH}-${GRAAL_VERSION}.tar.gz \
  && mkdir -p /opt/java/graalvm \
  && cd /opt/java/graalvm \
  && tar -xf /tmp/graalvm.tar.gz --strip-components=1 \
  && export PATH="/opt/java/graalvm/bin:$PATH" \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/graalvm.tar.gz
    
ENV JAVA_HOME=/opt/java/graalvm \
    PATH="/opt/java/graalvm/bin:$PATH"
    
# Step 2 - add pterodactyl stuff
RUN useradd -d /home/container -m container
    
USER        container
ENV         USER=container HOME=/home/container
    
WORKDIR     /home/container

# Install GraalJS standalone package
RUN curl --retry 3 -Lfso /tmp/graaljs.tar.gz https://github.com/oracle/graaljs/releases/download/vm-${GRAAL_VERSION}/graaljs-${GRAAL_VERSION}-linux-amd64.tar.gz \
    && mkdir -p ${HOME}/graaljs \
    && tar -xf /tmp/graaljs.tar.gz -C ${HOME}/graaljs --strip-components=1 \
    && rm /tmp/graaljs.tar.gz

# Add GraalJS to the PATH
ENV PATH="${HOME}/graaljs/bin:$PATH"

# Verify JavaScript is available
RUN js --version
    
COPY        ./../entrypoint.sh /entrypoint.sh
    
CMD         ["/bin/bash", "/entrypoint.sh"]