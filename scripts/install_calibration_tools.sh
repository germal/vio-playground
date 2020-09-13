KALIBR_WS="/calib/kalibr_ws"
IMU_UTILS_WS="/calib/imu_utils_ws"

source /scripts/catkin_init_ws_and_build.sh

catkin_init_ws_and_build "imu_utils" $IMU_UTILS_WS 1 "code_utils"
catkin_init_ws_and_build "imu_utils" $IMU_UTILS_WS 0 "imu_utils"
catkin_init_ws_and_build "kalibr" $KALIBR_WS 1 ""

echo "alias act_imu_utils='source $KALIBR_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_kalibr='source $IMU_UTILS_WS/devel/setup.bash'" >> ~/.bashrc
echo "alias act_calibration='act_kalibr && act_imu_utils'" >> ~/.bashrc
