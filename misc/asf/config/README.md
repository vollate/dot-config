start container:
`docker run -it -u 1001 -v <Path-to-config-dir>:/app/config --add-host host.docker.internal:host-gateway -p 127.0.0.1:1242:1242 -p "[::1]:1242:1242" --name asf justarchi/archisteamfarm`
