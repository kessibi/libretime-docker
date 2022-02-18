# libretime-docker (based on libretime 3.0.0-alpha9)![Docker Pulls](https://img.shields.io/docker/pulls/odclive/libretime-docker) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/odclive/libretime-docker)

Welcome in the documentation to install [LibreTime](https://libretime.org/) quickly within a Docker container.

This project is only here to simplify the installation of LibreTime in a *single* Docker container.

## Installation

First, run this command to download the image:

```
docker pull odclive/libretime-docker:latest
```

Then choose Method 1 or Method 2. Read them carefully.

### Method 1: Quick demo installation WITHOUT data persistence

This is the simplest way to try LibreTime standalone in a container but __NOT persisting__ any data.

This is useful __only for testing purposes__. If interested just run this command:

```
docker run -p 80:80 -p 8000:8000 -p 8001:8001 --name=libretime odclive/libretime-docker:latest
```

Now:
* See the "First run" section
* if you like this demo, kill everything and see the "Method 2" section.

### Method 2: Normal installation WITH data persistence

This is the LibreTime installation with data persistence thanks to Docker compose.

To do that is __strongly__ recommended you use a `docker-compose.yml` file, together with an `.env` file and save them into a directory.

Both files have an example in this repository so you can copy them somewhere.

If you need an example of these files, see here:

https://github.com/kessibi/libretime-docker/wiki/Sample-installation

After you created a directory with both files and you are inside that directory, run:

```
docker-compose up
```

Now the LibreTime webserver is running. See the next section.

### First LibreTime web configuration

On your first run, visit this address (or your server IP):

http://localhost

That URL should now serve the LibreTime welcome page.

Follow the instructions on your browser and answer questions. Having said it should work also pressing Next and leaving defaults.

At some point (it should be the point number 5) LibreTime will tell you to run lot of
`sudo service` commands. Instead, just run this in another terminal:

```
docker exec libretime sh /libre_start.sh
```

Good! Now you are ready to use LibreTime at its full power! Read the next section.

### Start and stop with Docker compose

If you have done the installation using Docker compose, you can just stop with:

```
docker-compose down
```

And start with:

```
docker-compose up
```

To simply pop you back to your installation.

Note: it may needed 15-30 seconds to restart. Enjoy your Libre radio!

## HTTPS

It is possible to serve this image via HTTPS using different tools, one option
is to use traefik and docker-compose as described in the wiki
[page](https://github.com/kessibi/libretime-docker/wiki/Using-traefik-to-serve-libretime-over-HTTPS).

Another option is to have a frontend HTTP proxy. This is very simple with Apache.
So you have Apache or nginx listening on port 443, forwarding traffic to LibreTime listening to a non-standard port.

To have free SSL certificates read about Let's Encrypt.

## Disclaimer

This installation is not secure, the logins and passwords provided are the
default ones. It is recommended to change them (icecast, libretime, postgres,..).

This work is still in progress.

## Thanks

The `systemctl.py` script (and the related operations in the Dockerfile) was not
at all developed by me but rather found in the repository
https://github.com/gdraheim/docker-systemctl-images

`systemctl` is needed for the installation script (icecast2, apache2, postgres,
...).

### About the image

This Docker image is based on the `ubuntu:18.04` base image, runs with postgres
10, php 7 and python 2.7 (libretime has not fully transitionned to python 3
yet).

The version of libretime used is [release 3.0.0-alpha9](https://github.com/LibreTime/libretime/releases/tag/3.0.0-alpha.9)

## Troubleshooting

Feel free to create an issue with your __detailed__ problem, make sure to
provide enough information to understand and recreate the problem.

## Updating stream configurations

Feel free to modify stream configs, just know you will have to run this command:

```
docker exec libretime sh /libre_start.sh
```

Afterwards to restart all services. Otherwise, liquidsoap just doesn't start up again.
If you find a clever way to tackle this issue, don't hesitate to bring it forward.

## Upgrade of the image

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
