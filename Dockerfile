# Use the official IPFS Kubo image
FROM ipfs/kubo:v0.34.1

# Set the environment variables for the paths
ENV IPFS_STAGING=/export
ENV IPFS_DATA=/data/ipfs

# Expose the necessary ports for IPFS
EXPOSE 4001 4001/udp 5001 8080

# Set up the entrypoint
ENTRYPOINT ["sh", "-c", "docker-entrypoint.sh"]

# Start the container with custom volumes for staging and IPFS data
CMD ["ipfs", "daemon"]
