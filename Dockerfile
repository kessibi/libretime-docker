FROM ubuntu:16.04

MAINTAINER "gui@odc.live"

ENV HOSTNAME localhost
ENV DEBIAN_FRONTEND noninteractive
ENV XDG_RUNTIME_DIR 0

LABEL __copyright__="(C) Guido Draheim, licensed under the EUPL" \
        __version__="1.4.3325"

RUN apt-get update && apt-get install --no-install-recommends -y locales git \
      ca-certificates rabbitmq-server apache2 curl python postgresql \
      postgresql-contrib

RUN locale-gen --purge en_US.UTF-8 && \
      update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

COPY systemctl.py /usr/bin/systemctl

RUN test -L /bin/systemctl || ln -sf /usr/bin/systemctl /bin/systemctl

COPY libre_start.sh /libre_start.sh
COPY preparation.sh /preparation.sh
RUN /preparation.sh

VOLUME ["/etc/airtime", "/var/lib/postgresql", "/srv/airtime/stor", "/srv/airtime/watch"]

EXPOSE 80 8000

CMD ["/usr/bin/systemctl"]
