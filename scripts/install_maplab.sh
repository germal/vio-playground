MAPLAB_WS="/work/maplab_ws"

source /scripts/catkin_init_ws_and_build.sh
catkin_init_ws_and_build "maplab" $MAPLAB_WS 0 "rovioli"
echo "alias act_maplab='source $MAPLAB_WS/devel/setup.bash'" >> ~/.bashrc

echo "export ROVIO_CONFIG_DIR=/cam/cfg/rovioli" >> ~/.bashrc
export ROVIO_CONFIG_DIR=/cam/cfg/rovioli

source ~/.bashrc