FROM node:6-slim

ADD ./oracle/linux/ .

RUN apt-get update && apt-get install unzip vim -y \
  && mkdir -p /opt/oracle \
  && unzip instantclient-basiclite-linux.x64-12.2.0.1.0.zip -d /opt/oracle \
  && unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /opt/oracle  \
  && mv /opt/oracle/instantclient_12_2 /opt/oracle/instantclient \
  && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so \
  && ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so \
  #CLEAN EVERYTHING
  && rm *.zip && apt-get remove -y --purge unzip && apt-get clean

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INC_DIR="/opt/oracle/instantclient/sdk/include"