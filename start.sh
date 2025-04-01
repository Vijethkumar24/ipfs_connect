#!/bin/bash

# Initialize IPFS
ipfs init --profile server

# Configure IPFS for public access and CORS
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST", "GET"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["X-Requested-With", "Content-Type", "Authorization"]'

# Enable gateway and API on all interfaces
ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

# Start IPFS daemon in the foreground
exec ipfs daemon --migrate=true