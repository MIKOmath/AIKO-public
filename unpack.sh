#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <password>"
    echo "Example: $0 mypassword"
    exit 1
fi

PASSWORD=$1
COUNT=0
FAILED=0

echo "Starting to unpack all zip files using provided password..."

for ZIP_FILE in *.zip; do
    if [ ! -f "$ZIP_FILE" ]; then
        echo "No zip files found in the current directory."
        exit 0
    fi
    
    echo "Unpacking: $ZIP_FILE"
    
    unzip -P "$PASSWORD" "$ZIP_FILE"
    
    if [ $? -eq 0 ]; then
        echo "Successfully unpacked: $ZIP_FILE"
        ((COUNT++))
    else
        echo "Failed to unpack: $ZIP_FILE (possibly wrong password or corrupted file)"
        ((FAILED++))
    fi
done

echo "Unpacking complete."
echo "$COUNT files successfully unpacked."
if [ $FAILED -gt 0 ]; then
    echo "$FAILED files failed to unpack."
fi
