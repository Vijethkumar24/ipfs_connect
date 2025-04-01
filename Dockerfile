# Use the official IPFS image
FROM ipfs/kubo:latest

# Optional: Set a default directory for IPFS data
WORKDIR /ipfs

# Optional: Expose ports for P2P, API, and Gateway
EXPOSE 4001 5001 8080

# Change user to 'ipfs' (if necessary)
USER ipfs

# Optional: Add a command to start the IPFS daemon
CMD ["ipfs", "daemon", "--enable-mdns", "--enable-relay-http", "--api", "/ip4/0.0.0.0/tcp/5001", "--gateway", "/ip4/0.0.0.0/tcp/8080"]
