#!/bin/bash

# Fetch the public IP address using an external service
ip_address=$(curl -s https://api.ipify.org)

# Output the public IP address
echo "{\"ip\": \"${ip_address}\"}"
