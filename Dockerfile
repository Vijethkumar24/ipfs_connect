FROM ipfs/kubo:latest

# Expose necessary ports
EXPOSE 4001/tcp
EXPOSE 4001/udp
EXPOSE 8080
EXPOSE 5001

# Create a setup script
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

# Run the setup script
ENTRYPOINT ["/usr/local/bin/start.sh"]

