#!/bin/sh
KEY=`xxd -p -c32 /dev/urandom | head -n1`
fteproxy --mode server \
             --upstream-format $UPSTREAM_FORMAT \
             --downstream-format $DOWNSTREAM_FORMAT \
             --client_ip $CLIENT_IP \
             --client_port $CLIENT_PORT \
             --server_ip $SERVER_IP \
             --server_port $SERVER_PORT \
             --proxy_ip $PROXY_IP \
             --proxy_port $PROXY_PORT \
             --release $RELEASE \
             --key $KEY  &
fteproxy --mode client \
             --upstream-format $UPSTREAM_FORMAT \
             --downstream-format $DOWNSTREAM_FORMAT \
             --client_ip $CLIENT_IP \
             --client_port $CLIENT_PORT \
             --server_ip $SERVER_IP \
             --server_port $SERVER_PORT \
             --proxy_ip $PROXY_IP \
             --proxy_port $PROXY_PORT \
             --release $RELEASE \
             --key $KEY

