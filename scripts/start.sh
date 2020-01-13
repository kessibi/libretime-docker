#!/bin/bash
mkdir -p /srv/airtime/stor
chown -R www-data:www-data /srv/airtime
chown -R www-data:www-data /etc/airtime
chown -R postgres:postgres /var/lib/postgresql

echo "Restarting postgres DB"
pg_ctlcluster 10 main restart

echo "Restarting libretime services"
/libre_start.sh

echo "Starting libretime container..."
