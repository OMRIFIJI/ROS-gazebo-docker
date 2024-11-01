# Dockerized ROS and Gazebo

## Overview
This is a setup that I use for ROS development. 
It consists of ROS noetic desktop and Gazebo.
Checkout original repository for [dockerfile](https://github.com/athackst/dockerfiles) of this branch.
This dockerfile adds support for GUI apps on machines with nvidia cards. 

If you are looking for dockerizing final version of your simulation take a look at 
[exec-only-base](https://github.com/OMRIFIJI/ROS-gazebo-docker/tree/exec-only-base) branch.
It uses more lightweight dockerfile and dockerizes workspace instead of mounting it.

## Quick start
It is expected that your `catkin_ws` is located inside this directory.
If you are using nvidia card the following will be sufficient:
* `git clone https://github.com/OMRIFIJI/ROS-gazebo-docker.git`
* `cd ROS-gazebo-docker`
* `docker build -t 'ros-gazebo' .`
* Choose one of 2 approaches (more about it in GUI section):
    1. `docker compose up`
    2. `./wrapped_docker_run.bash`
* Now you can enter container with bash: `docker exec -it ros-dev bash`

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
