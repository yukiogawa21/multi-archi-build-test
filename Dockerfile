# Use an official base image as a parent image
FROM alpine:3.12

# Determine the image architecture using the `uname` command and save the information in a file
RUN IMAGE_ARCH=$(uname -m) && \
    echo "Image Architecture: $IMAGE_ARCH" > /arch_info.txt

# Run the command to compare the host and image architectures, and then start the `ash` shell
CMD IMAGE_ARCH=$(cat /arch_info.txt | awk '{print $3}') && \
    HOST_ARCH=$(uname -m) && \
    if [ "$HOST_ARCH" = "$IMAGE_ARCH" ]; then \
        echo "Host and image architectures match: $HOST_ARCH"; \
    else \
        echo "WARNING: Host architecture ($HOST_ARCH) and image architecture ($IMAGE_ARCH) do not match"; \
    fi && \
    exec ash
