# ROS SETUP AND SOURCING
ROS_VERSION=kinetic
WORK_ROOT=/work
echo "[Set the ROS evironment]"
echo "export LC_ALL=C.UTF-8" >> ~/.bashrc
echo "export LANG=C.UTF-8" >> ~/.bashrc
echo "source /opt/ros/$ROS_VERSION/setup.bash" >> ~/.bashrc
sh -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
sh -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"
sh -c "echo \"export ROS_PACKAGE_PATH=$WORK_ROOT:/opt/ros/$ROS_VERSION/share\" >> ~/.bashrc"
