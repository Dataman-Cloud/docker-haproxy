docker run -d \
	-e BACKEND_LIST=192.168.1.221,192.168.1.222,192.168.1.223 \
	-e BACKEND_MAXCONN=20 \
	-e SERVICE_NAME=test \
	-e SERVICE_PORT=7001 \
	-e BACKEND_PORT=7001 \
	-e HAPROXY_STATS_PORT=9001 \
	-v /var/run/haproxy:/run/haproxy \
	--net host \
	library/alpine3.4-haproxy-v1.6.9
