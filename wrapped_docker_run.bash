#!/bin/bash
xhost +SI:localuser:${USER} &&
docker run -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -e DISPLAY=$DISPLAY \
           --gpus all \
           --ulimit nofile=1024:524288 \
           -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
           -v ~/.Xauthority:/home/ros/.Xauthority \
           --name ros-dev \
           --user ros \
           -dt \
           ros-gazebo &&
xhost -SI:localuser:${USER}
