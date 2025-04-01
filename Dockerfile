FROM ipfs/kubo:latest

# Expose necessary IPFS ports
EXPOSE 4001 5001 8080

# Initialize IPFS (this creates the config file)
RUN ipfs init

# Set the working directory to avoid permission issues
WORKDIR /data/ipfs

# Run the IPFS daemon as root initially
USER root

# Ensure the /data/ipfs directory is created and has appropriate permissions
RUN mkdir -p /data/ipfs && chown -R root:root /data/ipfs

# Switch to ipfs user after setup (if needed)
USER ipfs

# Start the IPFS daemon
CMD ["ipfs", "daemon", "--migrate", "--enable-gc"]
