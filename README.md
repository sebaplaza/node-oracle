# node-oracle

This docker image contains Node 6 LTS and Oracle Instant Client 12.2.0.1
Is based on node:6-slim and instant client basic lite

The idea is to have the lightest node oracle docker image.
By the moment, is not possible to use an alpine image because the lack of glibc.

Some efforts have been made in this way https://github.com/sgerrand/alpine-pkg-glibc
But in running time of a node application using the driver oracledb we have incompatibility problems