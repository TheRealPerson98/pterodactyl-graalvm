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
rm -f test.js test-node.js

# Replace Startup Command
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP} 