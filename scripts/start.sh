#!/bin/bash
mkdir -p /srv/airtime/stor
chown -R www-data:www-data /srv/airtime/

pg_ctlcluster 10 main restart

echo "Starting libretime container..."
