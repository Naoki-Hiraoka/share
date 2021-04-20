```
mkdir catkin_ws/src -p
cd src

git clone https://github.com/Naoki-Hiraoka/share -b hrp2_with_3hand

wstool init .
wstool merge share/hrp2_with_3hand/.rosinstall
wstool update

## setup for euslisp
wget https://raw.githubusercontent.com/jsk-ros-pkg/jsk_roseus/master/setup_upstream.sh -O /tmp/setup_upstream.sh
bash /tmp/setup_upstream.sh -w .. -p jsk-ros-pkg/geneus

## setup for choreonoid
./choreonoid/misc/script/install-requisites-ubuntu-18.04.sh

rosdep install -r --from-paths . --ignore-src -y

## 順番が重要
catkin build choreonoid
catkin build hrpsys_choreonoid
catkin build jsk_hrp2_ros_bridge
catkin build hrpsys_choreonoid_tutorials
```
