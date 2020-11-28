cmake_minimum_required(VERSION 3.0.2)
project(hrp2jsknts_move_base_share)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

catkin_package()

find_package(hrp2_models REQUIRED)
find_package(hrpsys_choreonoid REQUIRED)
find_package(hrpsys_choreonoid_tutorials REQUIRED)
find_package(jsk_hrp2_ros_bridge REQUIRED)

set (HRP2_MODELS_DIR ${hrp2_models_SOURCE_PREFIX})
set(JVRC_RTC_DIRECTORY ${hrpsys_choreonoid_SOURCE_PREFIX})
set(JVRC_CONF_DIRECTORY ${hrpsys_choreonoid_tutorials_SOURCE_PREFIX}/config)
set (JSK_HRP2_ROS_BRIDGE_DIR ${jsk_hrp2_ros_bridge_SOURCE_PREFIX})

# rootPosition X is 1.0
configure_file(${PROJECT_SOURCE_DIR}/HRP2JSKNTS_LOAD_OBJ.cnoid.in ${PROJECT_SOURCE_DIR}/HRP2JSKNTS_LOAD_OBJ.cnoid @ONLY)
