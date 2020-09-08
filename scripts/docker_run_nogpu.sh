#!/bin/bash

####################################################################
#
# Change these to match your preference
# and make files available inside the container
#
# 
# PROJECT: absolute path to main folder  
# DATASET: absolute path to folder with sample datasets (euroc/tumvi)
# SCRIPTS: Utility scripts for running and setting up things
# OUTPUT:  Results from the VIO algorithms for benchmarking
#

PROJECT=/home/ruimsc98/connect_robotics/rovio-docker
DATASET=/media/ruimsc98/MASS/
SCRIPTS=/home/ruimsc98/connect_robotics/rovio-docker/scripts
OUTPUT=/home/ruimsc98/connect_robotics/rovio-docker/output
####################################################################

# Additional configs
default_name=newdrone
default_image=cr-all:openGL
NAME=${1:-$default_name}
IMAGE=${2:-$default_image}

# Create container (display enabled)
# Note: Privileged mode is used to simplify access to datasets in
#       external hdds
docker run --name "$NAME" -it --env="DISPLAY" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--privileged -v /dev:/dev \
	-v "$PROJECT/workspaces:/work" \
	-v "$PROJECT/d435i:/cam" \
	-v "$PROJECT/calibration:/calib" \
	-v "$DATASET:/data/dataset" \
	-v "$SCRIPTS:/scripts" \
	-v "$OUTPUT:/data/output" \
	$IMAGE bash
