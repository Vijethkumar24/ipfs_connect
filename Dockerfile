# Use the official IPFS image as the base
FROM ipfs/go-ipfs:latest

# Set the working directory
WORKDIR /ipfs

# Expose the necessary ports for IPFS
EXPOSE 4001 5001 8080

# Optional: Create a directory for persistent IPFS data
VOLUME /data/ipfs

# Run the IPFS daemon with writable data
CMD ["ipfs", "daemon", "--writable"]
