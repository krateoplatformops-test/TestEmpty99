#!/bin/bash

# Script to copy largefile.bin with different names multiple times
# Usage: ./copy_largefile.sh [number_of_copies] [prefix]

# Default values
DEFAULT_COPIES=35
DEFAULT_PREFIX="largefile_copy"

# Get parameters from command line or use defaults
NUM_COPIES=${1:-$DEFAULT_COPIES}
PREFIX=${2:-$DEFAULT_PREFIX}

# Check if largefile.bin exists
if [ ! -f "largefile.bin" ]; then
    echo "Error: largefile.bin not found in current directory!"
    exit 1
fi

# Validate number of copies is a positive integer
if ! [[ "$NUM_COPIES" =~ ^[0-9]+$ ]] || [ "$NUM_COPIES" -eq 0 ]; then
    echo "Error: Number of copies must be a positive integer!"
    echo "Usage: $0 [number_of_copies] [prefix]"
    exit 1
fi

echo "Creating $NUM_COPIES copies of largefile.bin with prefix '$PREFIX'..."

# Create copies
for i in $(seq 1 $NUM_COPIES); do
    copy_name="${PREFIX}_${i}.bin"
    
    # Check if file already exists
    if [ -f "$copy_name" ]; then
        echo "Warning: $copy_name already exists, skipping..."
        continue
    fi
    
    # Copy the file
    cp largefile.bin "$copy_name"
    
    if [ $? -eq 0 ]; then
        echo "✓ Created: $copy_name"
    else
        echo "✗ Failed to create: $copy_name"
    fi
done

echo "Done! Created copies in the current directory."
echo "To list all copies: ls -la ${PREFIX}_*.bin"
