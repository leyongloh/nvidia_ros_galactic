FROM arm64v8/ros:humble-ros-base-jammy
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
SHELL ["/bin/bash", "-c"]

# Install basic apt packages
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget \
  nano \
  ros-humble-simulation \
  ros-humble-rviz2

# install some pip packages needed for testing
RUN python3 -m pip install -U \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  setuptools

# Install additional ROS packages
RUN apt-get install -y \
  python3-numpy \
  libboost-python-dev 

# Create Catkin workspace with TurtleBot3 package and behavior tree source
RUN source /opt/ros/galactic/setup.bash \
 && mkdir -p /image_transport_tutorials_ws/src \
 && cd /image_transport_tutorials_ws/src \
 && git clone -b galactic https://github.com/ros-perception/image_transport_tutorials.git

# Install YOLOv5
RUN cd /image_transport_tutorials_ws/src \
 && git clone https://github.com/ultralytics/yolov5.git 
  
RUN cd /image_transport_tutorials_ws/src/yolov5 \
 && python3 -m pip install -r requirements.txt 

# Install torch for webcam detection project
RUN python3 -m pip install torch==1.10.1+cpu \
  torchvision==0.11.2+cpu \
  torchaudio==0.10.1 \
  -f https://download.pytorch.org/whl/torch_stable.html

RUN python3 -m pip install python-dateutil==2.8.2

# Build the base Catkin workspace
# RUN pip3 install osrf-pycommon
RUN cd /image_transport_tutorials_ws \
 && source /opt/ros/galactic/setup.bash \
 && rosdep install -y --from-paths src --rosdistro galactic -y \
 && colcon build

# Remove display warnings
RUN mkdir /tmp/runtime-root
ENV XDG_RUNTIME_DIR "/tmp/runtime-root"
ENV NO_AT_BRIDGE 1

# Set up the work directory and entrypoint
WORKDIR /image_transport_tutorials_ws
COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh"]