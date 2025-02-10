#!/bin/bash

# Ensure two arguments are passed: the .tar.gz file and the target directory
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path-to-tar.gz-file> <target-directory>"
    exit 1
fi

# Premier argument = path du tar.gz
# deuxieme argument le nom du repo que tu choisi d'assigner

TAR_GZ_FILE="$1"
TARGET_DIR="$2"

# Check if the file exists
if [ ! -f "$TAR_GZ_FILE" ]; then
    echo "File not found: $TAR_GZ_FILE"
    exit 1
fi

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to create target directory: $TARGET_DIR"
    exit 1
fi

# Extract the .tar.gz file to the target directory
tar -xzf "$TAR_GZ_FILE" -C "$TARGET_DIR" --strip-components=1
if [ $? -ne 0 ]; then
    echo "Failed to extract $TAR_GZ_FILE to $TARGET_DIR"
    exit 1
fi

# Navigate to the target directory
cd "$TARGET_DIR" || exit 1

# Run the configuration script (if available)
if [ -f "configure" ]; then
    ./configure
    if [ $? -ne 0 ]; then
        echo "Configuration failed"
        exit 1
    fi
fi

# Compile the program
make
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Install the program (requires root privileges)
sudo make install
if [ $? -ne 0 ]; then
    echo "Installation failed"
    exit 1
fi

echo "Installation completed successfully."

# Clean up (optional)
#rm -rf "$TARGET_DIR"
