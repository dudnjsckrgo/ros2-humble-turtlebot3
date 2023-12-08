FROM osrf/ros:humble-desktop-full

# Gazebo 설치
RUN apt-get update
RUN apt-get install -y 
RUN  apt install -y ros-humble-gazebo-*
RUN  apt install -y ros-humble-cartographer
RUN  apt install -y ros-humble-cartographer-ros
RUN apt install -y ros-humble-navigation2
RUN apt install -y ros-humble-nav2-bringup
RUN apt install -y ros-humble-dynamixel-sdk
RUN apt install -y ros-humble-turtlebot3-msgs
RUN apt install -y ros-humble-turtlebot3

# 환경 변수 설정
RUN echo "source /opt/ros/humble/setup.sh" >> ~/.bashrc
# nvidia-docker hooks
RUN apt install -y git

# 기타 필요한 설정 및 명령어 추가
# ROS2 작업 공간 설정
WORKDIR /root/ros2_ws/src/
RUN git clone https://github.com/noshluk2/ROS2-Autonomous-Driving-and-Navigation-SLAM-with-TurtleBot3

# colcon을 사용하여 프로젝트 빌드
WORKDIR /root/ros2_ws/
RUN /bin/bash -c '. /opt/ros/humble/setup.bash; colcon build'

# 작업 공간 소스 설정
RUN echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc
RUN apt install -y ros-humble-turtlebot3-simulations
