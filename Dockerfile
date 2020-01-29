FROM ubuntu:18.04

MAINTAINER "gui@odc.live"

ENV HOSTNAME localhost
ENV DEBIAN_FRONTEND noninteractive
ENV XDG_RUNTIME_DIR 0
ENV LIBRE_V 3.0.0-alpha.8

## Set UTF-8 ENV for id3 tags and filenames
RUN locale-gen "en_US.UTF-8" && \
    echo -e "LC_ALL=en_US.UTF-8\nLANG=en_US.UTF-8" >> /etc/default/locale
    
ENV PYTHONIOENCODING UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

COPY pkgs_list.apt /pkgs_list.apt

RUN apt-get update && apt-get install --no-install-recommends -y apt-utils && \
      apt-get install --no-install-recommends -y $(cat /pkgs_list.apt)


RUN mkdir /src && cd /src && \
      url="https://github.com/LibreTime/libretime/archive/$LIBRE_V.tar.gz" && \
      file=$(curl $url | sed 's/.* href="//' | sed 's/">.*//') && \
      curl $file -o libretime.tar.gz && tar xzvf libretime.tar.gz

WORKDIR "/src" 

RUN locale-gen --purge en_US.UTF-8 && \
      update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

COPY systemctl.py /usr/bin/systemctl

RUN test -L /bin/systemctl || ln -sf /usr/bin/systemctl /bin/systemctl

COPY pkgs_list.apt /pkgs_list.apt

RUN apt-get install --no-install-recommends -y $(cat /pkgs_list.apt)

COPY scripts/libre_start.sh /libre_start.sh

COPY scripts/preparation.sh /preparation.sh

RUN /preparation.sh

ADD scripts/start.sh /

RUN chmod +x /start.sh

RUN mkdir /liquidsoap && \
      cp /usr/local/lib/python2.7/dist-packages/airtime_playout-1.0-py2.7.egg/liquidsoap/* /liquidsoap

WORKDIR /

VOLUME ["/etc/airtime", "/var/lib/postgresql/10/main", "/srv/airtime/stor", \
  "/srv/airtime/watch", "/usr/local/lib/python2.7/dist-packages/airtime_playout-1.0-py2.7.egg/liquidsoap/"]

EXPOSE 80 8000

CMD /start.sh && exec /usr/bin/systemctl
