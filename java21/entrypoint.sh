#!/bin/bash
cd /home/container

# Output Current Java Version
java -version

# Test JavaScript and Node.js
echo "Testing JavaScript..."
echo "console.log('JavaScript test from GraalVM');" > test.js
js test.js
echo "Testing Node.js..."
echo "console.log('Node.js test from GraalVM');" > test-node.js
node test-node.js

# Test Polyglot API
echo "Testing Polyglot API..."
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
java -cp ".:$JAVA_HOME/lib/graal-sdk-23.0.1.jar" TestPolyglot

# Clean up test files
rm -f test.js test-node.js test-polyglot.java TestPolyglot.class

# Replace Startup Command
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP} 