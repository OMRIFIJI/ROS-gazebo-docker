FROM ros:noetic-ros-base-focal

###########################################
# Set up user
###########################################
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=$USER_UID

#Create a non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #Add sudo support for the non-root user
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/* \
    && usermod -a -G video $USERNAME \
    && usermod -a -G sudo $USERNAME \
    && usermod -a -G root $USERNAME

# Set up autocompletion for user
RUN apt-get update && apt-get install -y git-core bash-completion \
    && echo "if [ -f /opt/ros/${ROS_DISTRO}/setup.bash ]; then source /opt/ros/${ROS_DISTRO}/setup.bash; fi" >> /home/$USERNAME/.bashrc \
    && echo "if [ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash ]; then source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash; fi" >> /home/$USERNAME/.bashrc

###########################################
# Additional ros packages
###########################################

# Additional dependencies
# RUN apt-get install -y \
#     ros-noetic-xacro \
#     ros-noetic-rviz

###########################################
# Gazebo
###########################################

# Install gazebo
RUN apt-get install -y \
    ros-noetic-gazebo*

###########################################
# Nvidia
###########################################

# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV QT_X11_NO_MITSHM 1

###########################################
# Copying workspace and entrypoints
###########################################
ENV DEBIAN_FRONTEND=

COPY catkin_ws /catkin_ws
COPY entrypoint_simulation.bash /home/ros/entrypoint_simulation.bash
RUN chmod +x /home/ros/entrypoint_simulation.bash

SHELL ["/bin/bash", "-c"]
