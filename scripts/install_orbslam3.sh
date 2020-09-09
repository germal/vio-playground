ORB_SLAM_WS=/work/ORB_SLAM3

#cd $ORB_SLAM_WS
#chmod +x build.sh
#./build.sh

echo "export ROS_PACKAGE_PATH=/opt/ros/kinetic/share:${ORB_SLAM_WS}/Examples/ROS" >> ~/.bashrc
#echo "alias act_orb=source $ORB_SLAM_WS/Examples/ROS" >> ~/.bashrc

cd $ORB_SLAM_WS
chmod +x build_ros.sh 
./build_ros.sh
