# node-oracle

[![ci](https://github.com/sebaplaza/node-oracle/actions/workflows/docker.yml/badge.svg)](https://github.com/sebaplaza/node-oracle/actions/workflows/docker.yml)

[node-oracle on Docker HUB](https://hub.docker.com/repository/docker/sebaplaza/node-oracle)

This docker image contains Node 6...16 LTS and Oracle Instant Client 12.2.0.1
Is based on node slim images and instant client basic lite

Is a very light image ~270mb !

The idea is to have the lightest node oracle docker image.
By the moment, is not possible to use an alpine image because the lack of glibc.

Some efforts have been made in this way https://github.com/sgerrand/alpine-pkg-glibc
But in running time of a node application using the driver oracledb we have incompatibility problems

## Usage (in your Dockerfile)

```dockerfile
FROM sebaplaza/node-oracle:16
WORKDIR /src

# Provides cached layer for node_modules
ADD package*.json .npmrc .

# We add some dependencies for build node-gyp native node_modules (like oracledb)
# https://github.com/nodejs/node-gyp
# we do it here because we only need them to install npm dependencies, we can remove them later
RUN apt-get update \
    && apt-get install -y python make g++ \
    # Install npm modules
    && npm ci --production \
    # Clean everything
    && npm cache clean --force \
    && apt-get remove -y --purge python make g++ \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define working directory
ADD . /src/

# Define env variables
ENV NODE_ENV 'production'

# Expose port
EXPOSE 80

# Run app
CMD ["node", "server.js"]
```
