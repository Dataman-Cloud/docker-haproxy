#FROM demoregistry.dataman-inc.com/library/haproxy:1.5.18-alpine
FROM demoregistry.dataman-inc.com/library/haproxy:1.6.9-alpine

COPY docker-entrypoint.sh /
COPY haproxy.cfg.temp /usr/local/etc/haproxy/
COPY build_config.sh /usr/local/etc/haproxy/

RUN chmod +x /usr/local/etc/haproxy/build_config.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
