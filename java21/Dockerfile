FROM ghcr.io/graalvm/graalvm-community:21.0.0

# Install GraalVM JavaScript
RUN gu install js

# Set up environment
ENV JAVA_HOME=/opt/graalvm \
    PATH="/opt/graalvm/bin:$PATH"

# Verify installations
RUN java -version && node --version && js --version