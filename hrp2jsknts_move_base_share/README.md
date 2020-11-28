```
mkdir catkin_ws/src -p
cd src

git clone https://github.com/Naoki-Hiraoka/share -b hrp2jsknts-move-base

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

rosdep install -r --from-paths . --ignore-src -y
source ~/.bashrc
catkin build hrp2jsknts_move_base_share
```