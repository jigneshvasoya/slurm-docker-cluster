FROM ubuntu:16.04
MAINTAINER jigneshvasoya

RUN apt -y update && apt -y install \
           munge \
           slurmd \
           slurmctld \
           slurmdbd \
           slurm-client \
           mariadb-server \
           psmisc \
           bash-completion

COPY slurm.conf /etc/slurm/slurm.conf
COPY slurmdbd.conf /etc/slurm/slurmdbd.conf

ADD gosu-amd64 /usr/local/bin/gosu
RUN chmod +x /usr/local/bin/gosu \
    && gosu nobody true

RUN service munge start

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["slurmdbd"]
