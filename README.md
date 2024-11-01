# Dockerized ROS and Gazebo

## Overview
This is a setup that I use to dockerize final versions of ROS projects.
It consists only of ROS noetic base and Gazebo. All dependencies should be added in Dockerfile manually.
This dockerfile adds support for GUI apps on machines with nvidia cards. 
Your `catkin_ws` will be copied inside container by default. 
If you want to mount it make according changes to dockerfile and *docker run*/*docker compose*.

## Quick start
It is expected that your `catkin_ws` is located inside this directory.
If you are using nvidia card the following will be sufficient:
* `git clone https://github.com/OMRIFIJI/ROS-gazebo-docker.git`
* `cd ROS-gazebo-docker`
* Include additional dependencies in Dockerfile
* `docker build -t 'ros-gazebo' .`
* define entrypoint of your project in `entrypoint_simulation.bash` script
* Choose one of 2 approaches (more about it in GUI section):
    1. `docker compose up`
    2. `./wrapped_docker_run.bash`

## Graphics card
If you don't use nvidia card mounting your device should be sufficient.
If you are still having issues try removing `gpus --all` from *wrapped_docker_run* 
or deploy of nvidia card from *docker_compose*.
Be aware that you may have problems with lights in Gazebo if your card is not nvidia. 
Checkout [this issue](https://github.com/gazebosim/gazebo-classic/issues/2623) for more info.

## GUI support
Another problem with GUI inside docker is allowing container to communicate with X (or Xwayland) server on your machine.
Here I've used 2 approaches with different vulnerabilities:
1. In *docker_compose* file `network_mode` is set to "host".
2. In *wrapped_docker_run.bash* `xhost` command is used to allow connection to X server.
