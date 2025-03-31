#!/bin/bash

# declaration ville
ville="$1"

# curl la meteo avec https://wttr.in/

curl https://wttr.in/$ville | head -n 6

