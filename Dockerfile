FROM andresb39/haproxycentos:v3

RUN yum update -y && yum install -y supervisor

ADD ./cfg_files/supervisor.conf /etc/myapp/supervisord.conf
ADD ./cfg_files/cli /usr/bin/cli
ADD ./cfg_files/haproxy.cfg /etc/haproxy/haproxy.cfg
ADD ./cfg_files/licenses /licenses
ADD ./cfg_files/etcd.conf /etc/etcd/etcd.conf
ADD ./cfg_files/start-standalone /etcd/
ADD ./cfg_files/start-local-cluster /etcd/
RUN chmod +x /etcd/start-local-cluster
RUN chmod +x /etcd/start-standalone

EXPOSE 5432 7000 2379 2380 80

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/myapp/supervisord.conf"]
