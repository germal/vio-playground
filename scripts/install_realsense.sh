REALSENSE_WS="/cam/realsense_ws"

source /scripts/catkin_init_ws_and_build.sh
catkin_init_ws_and_build "realsense" $REALSENSE_WS 1 ""
echo "alias act_realsense='source $REALSENSE_WS/devel/setup.bash'" >> ~/.bashrc
