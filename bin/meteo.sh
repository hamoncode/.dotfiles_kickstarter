#!/bin/bash

# Si aucun argument n'est fourni, la ville par défaut sera 'gatineau'
ville=${1:-gatineau}

curl -sS "http://wttr.in/${ville}" | head -n 7
