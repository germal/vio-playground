function catkin_init_ws_and_build() {
	echo -e "\n[Make $1 workspace] >>> $2"
	cd $2
	ls
	if [ $3 -eq 1 ]; then
		rm -rf devel || true
		echo "remove devel $3"
		sleep 3
	fi
	rm -rf build logs .catkin_tools || true
	pwd
	catkin init
	catkin config --merge-devel # Necessary for catkin_tools >= 0.4.
	catkin config --extend /opt/ros/kinetic
	catkin config --cmake-args \
        -DCMAKE_BUILD_TYPE=Release \
		-DMAKE_SCENE=ON \
		-DBUILD_WITH_MARCH_NATIVE=ON \
    	-DUSE_PANGOLIN_VIEWER=ON \
		-DUSE_SOCKET_PUBLISHER=OFF \
		-DUSE_STACK_TRACE_LOGGER=ON \
	   	-DBOW_FRAMEWORK=DBoW2

	echo -e "\n[Build $1]"
	catkin build $4 
	catkin build $4
	echo -e "[Build finished]"
}
