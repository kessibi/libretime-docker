# libretime-docker

One way to get libretime to work within a docker container.

This project is only here to simplify the installation of libretime in a
*single* docker container.

## disclaimers

This installation is not secure, the logins and passwords provided are the
default ones. This work is still in progress.

## work of others

The `systemctl.py` script (and the related operations in the Dockerfile) was not
at all developed by me but rather found in the repository
https://github.com/gdraheim/docker-systemctl-images

`systemctl` is needed for the installation script (icecast2, apache2, postgres,
...).

## installation

### Using Docker Hub

The image is available from `docker pull odclive/libretime-docker`.
You still need to go through steps 5 to 8.

### Building the image yourself

The first 4 steps will install libretime in a dedicated container.

1. `git clone https://github.com/kessibi/libretime-docker.git`
2. `cd libretime-docker`
3. `docker build -t my_libretime_install:latest .` please note that the image
will take some time to build as it needs to build a correct Ubuntu environment
and clone libretime as well.
4. `docker run -d -p 80:80 -p 8000:8000 my_libretime_install:latest`

Visiting http://localhost / your server ip / the domain you're using will now
render the basic libretime page. However, you won't be able to confirm the
database entries as you will realize the screen is covered in red. Dont't worry,
it is *normal* and easy to fix.

5. `docker ps` will give you the id of your libretime container, copy it and run
`docker exec -it <id> bash`, replacing `<id>` with the one you just got.
6. inside the container, run `pg_lsclusters`. This should give you one postgres
entry which is going to be down. You __have__ to bring it up using
`pg_ctlcluster`. For example: `pg_ctlcluster 9.5 main start`.
7. You can now continue the installation on your browser.
8. libretime will ask you to perform some `sudo service` actions. Inside the
container, instead of running `sudo service x start`, run `./libre_start.sh`, it
will restart every service.
9. You are done with the installation, enjoy your new libretime radio.
