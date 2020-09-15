ORBSLAM2_WS="/work/ORB_SLAM2_ws"

source /scripts/catkin_init_ws_and_build.sh
catkin_init_ws_and_build "orb2" $ORBSLAM2_WS 1 ""
echo "alias act_orbslam2='source $ORBSLAM2WS/devel/setup.bash'" >> ~/.bashrc
