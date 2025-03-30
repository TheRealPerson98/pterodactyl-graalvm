#!/bin/bash
cd /home/container

# Output Current Java Version
java -version

# Test JavaScript and Node.js
echo "Testing JavaScript..."
echo "console.log('JavaScript test from GraalVM');" 
# Make sure the GraalVM JARs are available
echo "Available GraalVM JARs:"
ls -la $JAVA_HOME/lib/graal* $JAVA_HOME/lib/js* $JAVA_HOME/lib/truffle*

# Set up classpath for the server to access GraalVM JavaScript
export CLASSPATH="$CLASSPATH:$JAVA_HOME/lib/graal-sdk-23.0.1.jar:$JAVA_HOME/lib/js-23.0.1.jar:$JAVA_HOME/lib/truffle-api-23.0.1.jar"

# Replace Startup Command
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Add GraalVM JARs to the classpath but don't modify the java command
# This approach adds the JARs to the classpath by adding them to the Java options
if [[ $MODIFIED_STARTUP == *"java "* ]]; then
    # Extract the java command and the arguments
    JAVA_CMD=$(echo $MODIFIED_STARTUP | awk '{print $1}')
    JAVA_ARGS=$(echo $MODIFIED_STARTUP | cut -d' ' -f2-)
    
    # Add the classpath option at the beginning of the arguments
    GRAALVM_CP="-cp $JAVA_HOME/lib/graal-sdk-23.0.1.jar:$JAVA_HOME/lib/js-23.0.1.jar:$JAVA_HOME/lib/truffle-api-23.0.1.jar:."
    
    # Rebuild the command with the classpath inserted after the java command
    MODIFIED_STARTUP="$JAVA_CMD $GRAALVM_CP $JAVA_ARGS"
fi

# Run the Server
echo "Starting server with: $MODIFIED_STARTUP"
eval ${MODIFIED_STARTUP} 