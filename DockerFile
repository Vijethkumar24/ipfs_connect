# Use the official IPFS image
FROM ipfs/kubo:latest

# Expose necessary ports
EXPOSE 4001 5001 8080


RUN ipfs init

# Set user to 'ipfs' to avoid permission issues
USER ipfs

CMD ["ipfs", "daemon", "--migrate", "--enable-gc"]

