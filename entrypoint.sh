#!/bin/bash
# Basic entrypoint for ROS / Colcon Docker containers

# Source ROS and Colcon workspaces
source /opt/ros/galactic/setup.bash
echo "Sourced ROS2 Galactic"
if [ -f /image_transport_tutorials_ws/install/setup.bash ]
then
  # echo "source /turtlebot3_ws/devel/setup.bash" >> ~/.bashrc
  source /image_transport_tutorials_ws/install/setup.bash
  echo "Sourced TurtleBot3 base workspace"
fi
if [ -f /image_transport_tutorials_ws/install/setup.bash ]
then
  # echo "source /overlay_ws/devel/setup.bash" >> ~/.bashrc
  source /image_transport_tutorials_ws/install/setup.bash
  echo "Sourced autonomy overlay workspace"
fi

# Execute the command passed into this entrypoint
exec "$@"