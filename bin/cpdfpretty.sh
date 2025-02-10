#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 input.md"
    exit 1
fi

# Assign the input argument to a variable
input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file '$input_file' does not exist."
    exit 1
fi

# Extract the base name (without extension) and create the output filename
base_name=$(basename "$input_file" .md)
output_file="${base_name}.pdf"

# Run the pandoc command to convert Markdown to PDF
pandoc "$input_file" -o "$output_file"

# Check if the conversion was successful
if [ $? -eq 0 ]; then
    echo "Conversion successful: '$input_file' -> '$output_file'"
else
    echo "Conversion failed."
    exit 1
fi

