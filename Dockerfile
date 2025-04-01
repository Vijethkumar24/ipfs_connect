# Use the official IPFS image
FROM ipfs/go-ipfs:latest

# Optional: Copy custom configuration
COPY ipfs-config /data/ipfs/config

# Expose IPFS ports
EXPOSE 4001 5001 8080

# Start IPFS
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/start_ipfs"]
CMD ["daemon", "--migrate=true", "--enable-gc=true"]