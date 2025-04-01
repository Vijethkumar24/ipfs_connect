# Use the official IPFS image
FROM ipfs/go-ipfs:latest

# Expose IPFS API and gateway ports
EXPOSE 5001 8080

# Set the default IPFS configuration
ENTRYPOINT ["/go-ipfs/ipfs", "daemon", "--api", "/ip4/0.0.0.0/tcp/5001", "--gateway", "/ip4/0.0.0.0/tcp/8080"]
