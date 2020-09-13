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

PROJECT=/home/ruimsc98/connect_robotics/vio-playground
DATASET=/media/ruimsc98/MASS/dataset
OUTPUT=/home/ruimsc98/MASS/output
####################################################################

# Additional configs
default_name=vio-playground
default_image=cr-all:openGL
NAME=${1:-$default_name}
IMAGE=${2:-$default_image}

# Create container (display enabled)
# Note: Privileged mode is used to simplify access to datasets in
#       external hdds
docker run --name "$NAME" -it --env="DISPLAY" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--privileged -v /dev:/dev \
	--gpus all \
	-v "$PROJECT/workspaces:/work" \
	-v "$PROJECT/d435i:/cam" \
	-v "$PROJECT/evaluation:/eval" \
	-v "$PROJECT/calibration:/calib" \
	-v "$PROJECT/scripts:/scripts" \
	-v "$PROJECT/visualization:/viz" \
	-v "$DATASET:/data/dataset" \
	-v "$OUTPUT:/data/output" \
	$IMAGE bash
