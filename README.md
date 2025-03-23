# GraalVM Docker Images for Pterodactyl

This repository contains Pterodactyl-compatible Docker images for GraalVM with JavaScript support for different Java versions.

## Available Images

### Java 11
- Tag: `ghcr.io/therealperson98/graalvm-js-java11:latest`
- GraalVM Version: 22.3.0
- [Documentation](java11/README.md)

### Java 17
- Tag: `ghcr.io/therealperson98/graalvm-js-java17:latest`
- GraalVM Version: 22.3.0
- [Documentation](java17/README.md)

### Java 19
- Tag: `ghcr.io/therealperson98/graalvm-js-java19:latest`
- GraalVM Version: 22.3.1
- [Documentation](java19/README.md)

### Java 21
- Tag: `ghcr.io/therealperson98/graalvm-js-java21:latest`
- GraalVM Version: 23.1.1
- [Documentation](java21/README.md)

## Features
- Ubuntu 22.04 base image
- GraalVM Community Edition with JavaScript support
- Multi-architecture support (amd64, arm64)
- Pterodactyl-compatible
- Minimum Panel Version: 1.7.0

## Usage
Choose the appropriate image based on your Java version requirements. Each version has its own directory with specific documentation and Dockerfile.

## License
This project is licensed under the MIT License - see the individual image directories for details. 