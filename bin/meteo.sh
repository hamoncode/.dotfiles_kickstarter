#!/bin/bash

<<<<<<< HEAD
# declaration ville

# curl la meteo avec https://wttr.in/

curl -sS https://wttr.in/Gatineau | head -n 7
=======
# Si aucun argument n'est fourni, la ville par défaut sera 'gatineau'
ville=${1:-gatineau}
>>>>>>> vincent

curl -sS "http://wttr.in/${ville}" | head -n 7
