ORB_SLAM_WS=/work/ORB_SLAM3

#cd $ORB_SLAM_WS

#chmod +x build.sh
#./build.sh

echo "export ROS_PACKAGE_PATH=${ORB_SLAM_WS}/Examples/ROS/ORB_SLAM3:${ROS_PACKAGE_PATH}" >> ~/.bashrc

cd $ORB_SLAM_WS
chmod +x build_ros.sh 
./build_ros.sh
