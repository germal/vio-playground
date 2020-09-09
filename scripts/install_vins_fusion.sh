CERES_DIR='/work/dependencies/ceres'
VINS_WS="/work/vins_fusion_ws"

if [ ! -d "$CERES_DIR" ]; then
    echo "No ceres installation found at $CERES_DIR"
    echo "Please install ceres before continuing. Aborted."
else 
    source /scripts/catkin_init_ws_and_build.sh
    catkin_init_ws_and_build "vins" $VINS_WS 1 ""
    echo "alias act_vins='source $VINS_WS/devel/setup.bash'" >> ~/.bashrc
fi
