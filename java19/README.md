# Java 19 with GraalVM

This is a Pterodactyl-compatible Docker image running GraalVM Java 19 with JavaScript support.

## Features
- Based on Ubuntu 22.04
- GraalVM CE 22.3.1
- Java 19
- JavaScript support via GraalVM
- Multi-architecture support (amd64, arm64)

## Versions
- Ubuntu: 22.04
- GraalVM: 22.3.1
- Java: 19

## Docker Pull Command
```bash
docker pull ghcr.io/therealperson98/graalvm-js-java19:latest
```

## Environment Variables
- `DEBIAN_FRONTEND=noninteractive`
- `LANG='en_US.UTF-8'`
- `LANGUAGE='en_US:en'`
- `LC_ALL='en_US.UTF-8'`
- `JAVA_HOME=/opt/java/graalvm`
- `PATH="/opt/java/graalvm/bin:$PATH"` 