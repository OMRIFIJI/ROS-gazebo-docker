#!/bin/bash

sudo docker run -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -e DISPLAY=$DISPLAY \
           -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY \
           --name rover \
           --gpus all \
           -v $PWD/catkin_ws/:/catkin_ws \
           -dt \
           --ulimit nofile=1024:524288 \
           --network host \
           ros_gazebo 
