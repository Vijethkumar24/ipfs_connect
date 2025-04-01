FROM ipfs/kubo:latest

# Expose necessary ports
EXPOSE 4001/tcp
EXPOSE 4001/udp
EXPOSE 8080
EXPOSE 5001

# Create a script in the entrypoint directory that IPFS/kubo uses
RUN echo '#!/bin/sh \n\
    ipfs init --profile server \n\
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "[\"*\"]" \n\
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods "[\"PUT\", \"POST\", \"GET\"]" \n\
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers "[\"X-Requested-With\", \"Content-Type\", \"Authorization\"]" \n\
    ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001 \n\
    ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080 \n\
    exec ipfs daemon --migrate=true \n\
    ' > /container-init.d/001-initialize-ipfs.sh

# Make the script executable
RUN chmod +x /container-init.d/001-initialize-ipfs.sh