# Webcam Object Detection with YOLOv5

# Docker
docker run -it --net=host --gpus all \
        --device=/dev/video0:/dev/video0 \
        --env="NVIDIA_DRIVER_CAPABILITIES=all" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --volume="/home/leyong/projects/nvidia_ros_galactic/src:/persistent_storage:rw" \
        --name yolov5_webcam \
        ros_image_transport_test bash

# Bash
1. ros2 run image_transport_tutorials publisher_from_video 0
2. cd src/yolobot_recognition/scripts
3. python3 ros_recognition_yolo.py


# References 
YOLOv5 - https://www.youtube.com/watch?v=594Gmkdo-_s
Webcam with OpenCV - https://github.com/ros-perception/image_transport_tutorials/tree/galactic