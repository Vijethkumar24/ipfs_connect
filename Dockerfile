FROM ipfs/kubo:latest

# Expose necessary ports
EXPOSE 4001/tcp
EXPOSE 4001/udp
EXPOSE 8080
EXPOSE 5001

# Create the startup script directly in the Dockerfile
RUN echo '#!/bin/bash\n\
    # Initialize IPFS\n\
    ipfs init --profile server\n\
    \n\
    # Configure IPFS for public access and CORS\n\
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "[\"*\"]"\n\
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods "[\"PUT\", \"POST\", \"GET\"]"\n\
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers "[\"X-Requested-With\", \"Content-Type\", \"Authorization\"]"\n\
    \n\
    # Enable gateway and API on all interfaces\n\
    ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001\n\
    ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080\n\
    \n\
    # Start IPFS daemon in the foreground\n\
    exec ipfs daemon --migrate=true\n'\
    > /usr/local/bin/start.sh

# Make the script executable
RUN chmod +x /usr/local/bin/start.sh

# Run the setup script
CMD ["/bin/bash", "/usr/local/bin/start.sh"]