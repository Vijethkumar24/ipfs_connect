# Use the official IPFS image
FROM ipfs/kubo:latest

# Expose necessary ports
EXPOSE 4001 5001 8080

# Set up the IPFS data directory
VOLUME /data/ipfs

# Initialize IPFS
RUN ipfs init

# Start the IPFS daemon
CMD ["ipfs", "daemon", "--migrate", "--enable-gc"]
