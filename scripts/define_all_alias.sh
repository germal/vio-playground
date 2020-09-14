MAPLAB_WS="/work/maplab_ws"
ORB_SLAM2_WS="/work/ORB_SLAM2_ws"
ROVIO_WS="/work/rovio_ws"
VINS_WS="/work/vins_fusion_ws"


echo "alias act_ros='source /opt/ros/kinetic/setup.bash'" >> ~/.bashrc
echo "alias act_maplab='source $MAPLAB_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_orb_slam2='source $ORB_SLAM2_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_rovio='source $ROVIO_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_vins='source $VINS_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_imu_utils='source $KALIBR_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_kalibr='source $IMU_UTILS_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_calibration='act_kalibr && act_imu_utils'" >> ~/.bashrc

source ~/.bashrc