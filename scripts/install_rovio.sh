ROVIO_WS="/work/rovio_ws"

source /scripts/catkin_init_ws_and_build.sh
catkin_init_ws_and_build "rovio" $ROVIO_WS 1 ""
echo "alias act_rovio='source $ROVIO_WS/devel/setup.bash'" >> ~/.bashrc
