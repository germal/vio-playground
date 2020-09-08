# Build packages
cd /cam/realsense_ws
catkin build ddynamic_reconfigure
catkin build librealsense2 -j4
catkin build realsense2_camera -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release 
echo "alias act_realsense='source /work/realsense_ws/devel/setup.bash'" >> ~/.bashrc
source ~/.bashrc
