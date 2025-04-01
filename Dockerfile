# Use the official IPFS image
FROM ipfs/go-ipfs:latest

# Optional: Set a default directory for IPFS data
WORKDIR /data/ipfs

# Optional: Expose ports for P2P, API, and Gateway
EXPOSE 4001 5001 8080

# Optional: Add a command to start the IPFS daemon
CMD ["ipfs", "daemon", "--migrate=true"]
