# cloning
echo "host    all             all             0.0.0.0/0 trust" >> /etc/postgresql/9.5/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf
pg_ctlcluster 9.5 main start

echo "** Cloning libretime in /src"
mkdir /src && cd /src
git clone https://github.com/LibreTime/libretime.git
cd libretime
sed '/pid=1 following any symlinks/a \ \ \ \ has_systemd_init=true; verbose "Detected init system type: systemd"; return 0' install > mod_install

mv mod_install install
chmod u+x install

# activate rabbitmq
echo "** Activating rabbitmq"
echo "NODENAME=rabbitmq@localhost" > /etc/rabbitmq/rabbitmq-env.conf
rabbitmq-plugins enable rabbitmq_management
/etc/init.d/rabbitmq-server start

# installing
echo "** Installing libretime"
./install -fiap
/etc/init.d/rabbitmq-server stop
cd / && rm -rf /src

echo "** Creating config files"
echo "localhost:5432:artime:airtime:airtime" > /root/.pgpass
chmod 600 /root/.pgpass
pg_ctlcluster 9.5 main restart
