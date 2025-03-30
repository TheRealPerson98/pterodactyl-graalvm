#!/bin/bash
cd /home/container

# Output Current Java Version
java -version

# Test Polyglot API
echo "Testing Polyglot API..."
# Test Polyglot API
cat > test-polyglot.java << EOF
import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.Source;
import org.graalvm.polyglot.Value;

public class TestPolyglot {
    public static void main(String[] args) {
        try {
            System.out.println("Creating Polyglot Context...");
            try (Context context = Context.create("js")) {
                String jsCode = "console.log('Hello from JavaScript via Polyglot API!'); 42;";
                Source source = Source.create("js", jsCode);
                Value result = context.eval(source);
                System.out.println("Result from JS evaluation: " + result.asInt());
                System.out.println("Polyglot API test passed successfully!");
            }
        } catch (Exception e) {
            System.err.println("Polyglot API test failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
EOF

javac -cp "$JAVA_HOME/lib/graal-sdk-23.0.1.jar" test-polyglot.java
if [ $? -ne 0 ]; then
    echo "WARNING: Failed to compile Polyglot test!"
    ls -la $JAVA_HOME/lib/graal-sdk*
fi

java -cp ".:$JAVA_HOME/lib/graal-sdk-23.0.1.jar" TestPolyglot
if [ $? -ne 0 ]; then
    echo "WARNING: Failed to run Polyglot test!"
fi

# Clean up test files
rm -f test.js test-node.js test-polyglot.java TestPolyglot.class

# Set up classpath for the server to access GraalVM JavaScript
export CLASSPATH="$CLASSPATH:$JAVA_HOME/lib/graal-sdk-23.0.1.jar:$JAVA_HOME/lib/js-23.0.1.jar:$JAVA_HOME/lib/truffle-api-23.0.1.jar"

# Add the GraalVM libraries to the Java class path when starting the server
GRAALVM_LIBS="-Djava.class.path=$JAVA_HOME/lib/graal-sdk-23.0.1.jar:$JAVA_HOME/lib/js-23.0.1.jar:$JAVA_HOME/lib/truffle-api-23.0.1.jar"

# Replace Startup Command
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Prepare any GRAALVM_LIBS if needed for the java command
if [[ $MODIFIED_STARTUP == *"java "* ]]; then
    # Only modify java commands
    MODIFIED_STARTUP=${MODIFIED_STARTUP/java /java $GRAALVM_LIBS /}
fi

# Run the Server
echo "Starting server with: $MODIFIED_STARTUP"
eval ${MODIFIED_STARTUP} 