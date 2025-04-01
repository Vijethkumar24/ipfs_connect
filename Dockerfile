# Use the official IPFS image
FROM ipfs/go-ipfs:latest

# Expose IPFS API and Gateway ports
EXPOSE 5001 8080

# Set the entrypoint to ensure the IPFS daemon starts correctly
ENTRYPOINT ["/go-ipfs/ipfs", "daemon", "--api", "/ip4/0.0.0.0/tcp/5001", "--gateway", "/ip4/0.0.0.0/tcp/8080"]
