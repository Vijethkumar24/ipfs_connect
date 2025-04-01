# Use the official IPFS Kubo image
FROM ipfs/kubo:v0.34.1

# Set environment variables for the IPFS data and staging directories
ENV IPFS_STAGING=/export
ENV IPFS_DATA=/data/ipfs

# Expose necessary ports for IPFS
EXPOSE 4001 4001/udp 5001 8080

# Set up the entrypoint to use the default entrypoint of the image
ENTRYPOINT ["ipfs", "daemon"]

# By default, the image uses entrypoint.sh automatically, which handles initialization and starting the IPFS daemon
