#
# Alpine linux docker image with OpenSSH client
#
# A minimal base image based on Alpine Linux with OpenSSH client
#

FROM alpine:latest


# Set environment variables.
ENV \
  TERM=xterm-color

# Install packages.
RUN \
  apk --update add bash openssh-client iproute2 curl drill && \
  rm -rf /var/cache/apk/*

# Set the default command.
CMD ["/bin/bash"]
