FROM ipfs/kubo:latest

# Expose necessary IPFS ports
EXPOSE 4001 5001 8080

# Create the 'ipfs' user and group
RUN addgroup -S ipfs && adduser -S ipfs -G ipfs

# Initialize IPFS (this creates the config file)
RUN ipfs init

# Ensure the /data/ipfs directory is owned by the 'ipfs' user
RUN mkdir -p /data/ipfs && \
    chown -R ipfs:ipfs /data/ipfs

# Switch to the ipfs user to run the IPFS daemon
USER ipfs

# Run IPFS daemon
CMD ["ipfs", "daemon", "--migrate", "--enable-gc"]