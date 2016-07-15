# rpi-python3.5
Dockerfile: Small raspbian container with python 3.5.2

A first attempt at a *small* raspbian container with latest python built in.

My work is lending heavily from [Tatsushid](https://hub.docker.com/u/tatsushid/) on [docker hub](http://hub.docker.com) and by heavily I mean a complete rip :)

## Build
As usual:
docker build -t rpi-python3.5 .

## Run
docker run -it generalaardvark/rpi-python3.5
