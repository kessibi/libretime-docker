#!/bin/bash
mkdir -p /srv/airtime/stor
chown -R www-data:www-data /srv/airtime
chown -R www-data:www-data /etc/airtime
chown -R postgres:postgres /var/lib/postgresql

echo "Restarting postgres DB"
pg_ctlcluster 10 main restart

if [ -e /liquidsoap ]
then
  echo "Setting up liquidsoap dir"
  mv /liquidsoap/* /usr/local/lib/python2.7/dist-packages/airtime_playout-1.0-py2.7.egg/liquidsoap/
  rm -rf /liquidsoap
fi

echo "Restarting libretime services"
/libre_start.sh

echo "Starting libretime container..."
