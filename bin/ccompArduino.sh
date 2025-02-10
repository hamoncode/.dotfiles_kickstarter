#!/bin/bash

# Check if the source file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <source_file.c>"
    exit 1
fi

# Set variables
SOURCE_FILE="$1"
BASE_NAME=$(basename "$SOURCE_FILE" .c)
OUTPUT_ELF="${BASE_NAME}.elf"
OUTPUT_HEX="${BASE_NAME}.hex"
MCU="atmega328p"  # This is still correct
MACHINE="uno"     # Updated machine type
F_CPU="16000000UL"

# Compile the source file
avr-gcc -mmcu="$MCU" -DF_CPU="$F_CPU" -o "$OUTPUT_ELF" "$SOURCE_FILE"

# Check if the compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

# Convert ELF to HEX
avr-objcopy -O ihex -R .eeprom "$OUTPUT_ELF" "$OUTPUT_HEX"

# Check if the conversion was successful
if [ $? -ne 0 ]; then
    echo "Conversion to HEX failed."
    exit 1
fi

echo "Compilation and conversion successful!"
echo "Output files: $OUTPUT_ELF, $OUTPUT_HEX"

# Run the simulation with QEMU
qemu-system-avr -machine "$MACHINE" -nographic -bios "$OUTPUT_HEX"

# Check if QEMU ran successfully
if [ $? -ne 0 ]; then
    echo "QEMU failed to run."
    exit 1
fi

