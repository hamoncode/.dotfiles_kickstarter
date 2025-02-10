#!/bin/bash

# Directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load the content of the template file into the clipboard
xclip -selection clipboard < "$DIR/template.txt"

# Paste the content wherever you need it
xdotool key ctrl+v
