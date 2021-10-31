# libretime-docker (based on libretime 3.0.0-alpha.10)![Docker Pulls](https://img.shields.io/docker/pulls/odclive/libretime-docker) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/odclive/libretime-docker)

One way to get libretime to work within a docker container.

This project is only here to simplify the installation of libretime in a
*single* docker container.

## installation

Simply run `docker pull odclive/libretime-docker:latest` to download the image.

To run a standalone __none persisting__ container (for testing purposes) you can 
use `docker run -p 80:80 -p 8000:8000 -p 8001:8001 --name=libretime odclive/libretime-docker:latest`.

To run a __persisting__ container, it is __strongly__ recommended you use a
`docker-compose.yml` file coupled with a `.env` file (you can find an example
for both of these in the project directory https://github.com/kessibi/libretime-docker).

Once set up, run `docker-compose up`. Visiting http://localhost / your server ip
/ the domain you're using will now render the basic libretime page. Follow the
instructions for installation. At some point, libretime will tell you to run
`sudo service` commands, simply run:

`docker exec libretime sh /libre_start.sh` and it's done.

__An example install is shown here:__ https://github.com/kessibi/libretime-docker/wiki/Sample-installation

You are done with the installation, running `docker-compose down` and `up` again
will simply pop you back to your installation (it may needed 15-30 seconds to
restart). Enjoy your radio.

## HTTPS

It is possible to serve this image via HTTPS using different tools, one option
is to use traefik and docker-compose as described in the wiki
[page](https://github.com/kessibi/libretime-docker/wiki/Using-traefik-to-serve-libretime-over-HTTPS)

## disclaimer

This installation is not secure, the logins and passwords provided are the
default ones. It is recommended to change them (icecast, libretime, postgres,..).
This work is still in progress.

## work of others

The `systemctl.py` script (and the related operations in the Dockerfile) was not
at all developed by me but rather found in the repository
https://github.com/gdraheim/docker-systemctl-images

`systemctl` is needed for the installation script (icecast2, apache2, postgres,
...).

## about the image

This Docker image is based on the `ubuntu:18.04` base image, runs with postgres
10, php 7 and python 2.7 (libretime has not fully transitionned to python 3
yet).

The version of libretime used is [release 3.0.0-alpha.10](https://github.com/LibreTime/libretime/releases/tag/3.0.0-alpha.10)

## having troubles with the image

Feel free to create an issue with your __detailed__ problem, make sure to
provide enough information to understand and recreate the problem.

## updating stream configurations

Feel free to modify stream configs, just know you will have to run `docker exec
libretime sh /libre_start.sh` afterwards to restart all services. Otherwise,
liquidsoap just doesn't start up again. If you find a clever way to tackle this
issue, don't hesitate to bring it forward.

## upgrade of the image

If you downloaded the image early on (before version 3.0.0-alpha9, you might
face these problems:

  - When updating the image, it is possible you had an image based on ubuntu 16
  (`cat /etc/os-release` in the Docker container),if it is the case you'll have
  to make sure your postgresql cluster gets updated from `9.5` to `10` (assuming
  you use volumes to store data).
  - Again, if your image is based on ubuntu 16, it is most probable that you
  can't upload songs. To fix the issue, please run this command inside the
  container: `chown -R www-data:www-data /srv/airtime/stor`.
  Thanks to @miasmaejuices for pointing that out.

