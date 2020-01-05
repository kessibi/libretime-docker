# libretime-docker

One way to get libretime to work within a docker container.

This project is only here to simplify the installation of libretime in a
*single* docker container.


## work of others

The `systemctl.py` script (and the related operations in the Dockerfile) was not
at all developed by me but rather found in the repository
https://github.com/gdraheim/docker-systemctl-images

`systemctl` is needed for the installation script (icecast2, apache2, postgres,
...).

## installation

### Using Docker Hub

Work in progress ..

### Building the image yourself

The first 4 steps will install libretime in a dedicated container.

1. `git clone https://github.com/kessibi/libretime-docker.git`
2. `cd libretime-docker`
3. `docker build -t my_libretime_install:latest .` please note that the image
will take some time to build as it needs to build a correct Ubuntu environment
and clone libretime as well.
4. `docker run -d -p 80:80 -p 8000:8000 my_libretime_install:latest`

Visiting http://localhost / your server ip / the domain you're using will now
render the basic libretime page.
