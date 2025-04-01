FROM ipfs/kubo:latest

# Expose necessary ports
EXPOSE 4001/tcp
EXPOSE 4001/udp
EXPOSE 8080
EXPOSE 5001

# Create the initialization script properly
RUN mkdir -p /container-init.d
COPY init-ipfs.sh /container-init.d/001-init-ipfs.sh
RUN chmod +x /container-init.d/001-init-ipfs.sh