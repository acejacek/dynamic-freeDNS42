#!/bin/bash

python /config/scripts/freedns-dyndns.py --newaddress "<dynamic>" | logger -t "FreeDNS::42"
