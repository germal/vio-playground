REALSENSE_WS="/cam/realsense_ws"

catkin_init_ws_and_build() {
	echo -e "\n[Make $1 workspace] >>> $2"
	cd $2
	ls
	if [ $3 -eq 1 ]; then
		rm -rf devel || true
		echo "remove devel $3"
		sleep 3
	fi
	rm -rf build logs .catkin_tools || true
	catkin init
	catkin config --merge-devel # Necessary for catkin_tools >= 0.4.
	catkin config --extend /opt/ros/kinetic
	catkin config --cmake-args \
        -DCATKIN_ENABLE_TESTING=False \
        -DCMAKE_BUILD_TYPE=Release

	echo -e "\n[Build $1]"
	catkin build $4 -j4
	catkin build $4 -j4
	echo -e "[Build finished]"
	sleep 5
}

#catkin_init_ws_and_build "realsense" $REALSENSE_WS 1 ""
echo "alias act_realsense='source $REALSENSE_WS/devel/setup.bash'" >> ~/.bashrc
