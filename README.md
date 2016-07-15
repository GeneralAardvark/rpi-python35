# rpi-python3.5
Dockerfile: Small raspbian container with python 3.5.2

A first attempt at a *small* raspbian container with latest python built in.

**rpi-python3.5.tgz** is a tar of python 3.5.2 build in a seperate raspbian container then extracted to be inserted into a fresh container here.
The reason being, I can't seem to clean up enough to get a nice small container size if I build and release in the same container.

My work is lending heavily from [Tatsushid](https://hub.docker.com/u/tatsushid/) on [docker hub](http://hub.docker.com) and by heavily I mean a complete rip :)
