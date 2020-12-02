```
mkdir catkin_ws/src -p
cd src

git clone https://github.com/Naoki-Hiraoka/share -b hrp2jsknts-move-base-auto-stabilizer

wstool init .
wstool merge share/hrp2jsknts_move_base_share/.rosinstall
wstool update

## setup for euslisp
wget https://raw.githubusercontent.com/jsk-ros-pkg/jsk_roseus/master/setup_upstream.sh -O /tmp/setup_upstream.sh
bash /tmp/setup_upstream.sh -w .. -p jsk-ros-pkg/geneus

## setup for choreonoid
./choreonoid/misc/script/install-requisites-ubuntu-18.04.sh

## setup for simtrans
cd simtrans
bash ./INSTALL
cd ..

## if real robot, comment out ``add_definitions(-DOPENHRP_PACKAGE_VERSION_320) ### cheat ##'' in CMakeLists.txt of hrpsys.

rosdep install -r --from-paths . --ignore-src -y

## 順番が重要
source ~/.bashrc
catkin build choreonoid
source ~/.bashrc
catkin build hrpsys_choreonoid # openhrp3のコンパイルエラーになったが、catkin build openhrp3したら通った
source ~/.bashrc
catkin build jsk_hrp2_ros_bridge
source ~/.bashrc
catkin build hrpsys_choreonoid_tutorials
source ~/.bashrc
catkin build hrp2jsknts_move_base_share
```

```
rtmlaunch hrpsys_choreonoid_tutorials hrp2jsknts_choreonoid.launch PROJECT_FILE:=`rospack find hrp2jsknts_move_base_share`/HRP2JSKNTS_LOAD_OBJ.cnoid ENVIRONMENT_YAML:=`rospack find eusurdfwrl`/worlds/room73b2.yaml
roslaunch jsk_hrp2jsknts_startup hrp2jsknts_2dnav.launch
rosrun jsk_footstep_controller head-controller.l
rosrun jsk_footstep_controller base-controller.l
```

rvizで2d nav goalをマウスで指定すると、その場所にロボットが歩く