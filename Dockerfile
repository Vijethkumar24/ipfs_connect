FROM ipfs/kubo:latest

# Expose necessary IPFS ports
EXPOSE 4001 5001 8080

# Initialize IPFS (this creates the config file)
RUN ipfs init

# Ensure the /data/ipfs directory is created and owned by root (default user in Docker container)
RUN mkdir -p /data/ipfs && chown -R root:root /data/ipfs

# Run IPFS daemon as the root user (default)
CMD ["ipfs", "daemon", "--migrate", "--enable-gc"]
