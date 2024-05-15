A few things to take note of:
* `xhost +local:root` is needed for GUI applications.
* `docker_run.bash` expect image to be build with *-t=ros_gazebo*.
* If you are using X instead of Wayland replace WAYLAND_DISPLAY with DISPLAY in `docker_run.bash`.
