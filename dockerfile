FROM "${KONG_DOCKER_TAG:-kong:latest}"
USER root

# # WORKDIR /opt/kong-js-pdk
# # RUN apt-get update
# # RUN apt-get install -y nodejs npm
# # COPY ./kong-js-pdk/ .

# WORKDIR /opt/kong-go-pdk
# COPY ./kong-go-pdk/ .

# # Install required dependencies for gvm
# RUN apt-get update && apt-get install -y git bash curl wget bash

# # Set the Go version
# ENV GO_VERSION=1.18

# # Download and install Go
# RUN wget -O go.tar.gz https://golang.org/dl/go${GO_VERSION}.linux-arm64.tar.gz && \
#     tar -C /usr/local -xzf go.tar.gz && \
#     rm go.tar.gz

# # Set Go environment variables
# ENV PATH=/usr/local/go/bin:$PATH
# ENV GOPATH=/go
# RUN echo go version

COPY ./lua-plugins/headerwrap /usr/local/share/lua/5.1/kong/plugins/headerwrap

USER kong
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8000 8443 8001 8444
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health
ENV KONG_CUSTOM_PLUGINS headewrap
CMD ["kong", "docker-start"]





