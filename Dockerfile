FROM andresb39/haproxycentos:v4
LABEL version="1.0"
LABEL mainteiner="J. Andres Bergano <andresb39@gmail.com>"

ADD ./cfg_files/supervisor.conf /etc/supervisord.conf
ADD ./cfg_files/haproxy.cfg /etc/haproxy/haproxy.cfg
ADD ./cfg_files/etcd.conf /etc/etcd/etcd.conf
ADD ./cfg_files/cli /usr/bin/cli
ADD ./cfg_files/start-standalone /etcd/
ADD ./cfg_files/start-local-cluster /etcd/
RUN chmod +x /etcd/start-local-cluster
RUN chmod +x /etcd/start-standalone

COPY ./licenses /licenses

EXPOSE 5432 7000 2379 2380 80

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
