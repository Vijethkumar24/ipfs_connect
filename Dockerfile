# Start with a base Ubuntu image
FROM ubuntu:20.04

# Install dependencies and IPFS
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    curl \
    bash \
    && wget https://dist.ipfs.io/go-ipfs/v0.14.0/go-ipfs_v0.14.0_linux-amd64.tar.gz \
    && tar -xvzf go-ipfs_v0.14.0_linux-amd64.tar.gz \
    && cd go-ipfs \
    && ./install.sh \
    && rm -rf /go-ipfs_v0.14.0_linux-amd64.tar.gz /go-ipfs

# Expose necessary ports
EXPOSE 5001 8080

# Initialize IPFS repository
RUN ipfs init

# Set the IPFS configuration for gateway (using config)
RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

# Set entrypoint to start IPFS daemon without the `--gateway` flag
ENTRYPOINT ["/usr/local/bin/ipfs", "daemon", "--api", "/ip4/0.0.0.0/tcp/5001"]
