# Step 1: Build Stage (Using Golang to compile the IPFS binary)
FROM golang:1.14-buster AS builder

LABEL maintainer="Steven Allen <steven@stebalien.com>"

# Install dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
    fuse

ENV SRC_DIR /go-ipfs

# Download Go modules first so they can be cached
COPY go.mod go.sum $SRC_DIR/
RUN cd $SRC_DIR && go mod download

# Copy the rest of the source code
COPY . $SRC_DIR

# Preload an in-tree but disabled-by-default plugin by adding it to the IPFS_PLUGINS variable
ARG IPFS_PLUGINS

# Build the IPFS binary
RUN cd $SRC_DIR \
    && mkdir .git/objects \
    && make build GOTAGS=openssl IPFS_PLUGINS=$IPFS_PLUGINS

# Step 2: Minimal Runtime Image (Using BusyBox)
FROM busybox:1.31.1-glibc

LABEL maintainer="Steven Allen <steven@stebalien.com>"

# Get the ipfs binary, entrypoint script, and other required binaries from the build container
ENV SRC_DIR /go-ipfs
COPY --from=builder $SRC_DIR/cmd/ipfs/ipfs /usr/local/bin/ipfs
COPY --from=builder $SRC_DIR/bin/container_daemon /usr/local/bin/start_ipfs
COPY --from=builder /tmp/su-exec/su-exec /sbin/su-exec
COPY --from=builder /tmp/tini /sbin/tini
COPY --from=builder /bin/fusermount /usr/local/bin/fusermount
COPY --from=builder /etc/ssl/certs /etc/ssl/certs

# Add suid bit on fusermount so it will run properly
RUN chmod 4755 /usr/local/bin/fusermount

# Fix permissions on start_ipfs (ignore the build machine's permissions)
RUN chmod 0755 /usr/local/bin/start_ipfs

# This shared lib (part of glibc) doesn't seem to be included with busybox.
COPY --from=builder /lib/*-linux-gnu*/libdl.so.2 /lib/

# Copy over SSL libraries.
COPY --from=builder /usr/lib/*-linux-gnu*/libssl.so* /usr/lib/
COPY --from=builder /usr/lib/*-linux-gnu*/libcrypto.so* /usr/lib/

# Expose the necessary ports for IPFS
EXPOSE 4001 
EXPOSE 5001 
EXPOSE 8080  
EXPOSE 8081  

# Create the IPFS file system repository (fs-repo) directory and switch to a non-privileged user
ENV IPFS_PATH /data/ipfs
RUN mkdir -p $IPFS_PATH \
    && adduser -D -h $IPFS_PATH -u 1000 -G users ipfs \
    && chown ipfs:users $IPFS_PATH

# Create mount points for `ipfs mount` command
RUN mkdir /ipfs /ipns \
    && chown ipfs:users /ipfs /ipns

# Expose the fs-repo as a volume

# Set default logging level
ENV IPFS_LOGGING ""

# This ensures that:
# 1. There's an fs-repo, and it initializes one if not already mounted.
# 2. The API and Gateway are accessible from outside the container.
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/start_ipfs"]

# Default command to run the IPFS daemon
CMD ["daemon", "--migrate=true"]
