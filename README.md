# Vio Playground

A Docker based approach to streamline open-source Visual(-Inertial) Odometry algorithms instalation, benchmarking and usage with an Intel® RealSense™ D435i.

## Getting started

To ensure maximum compatibility with most algorithms the developed docker image is based on Ubuntu 16.04 and ROS Kinetic.

### Realsense Drivers

Running this image in a VM is discouraged due to poor emulation of the USB 3.0+ driver according to the librealsense team.
If you're running an older ubuntu version you may need to apply a kernel patch please refer to [this post](https://dev.intelrealsense.com/docs/compiling-librealsense-for-linux-ubuntu-guide).

### Nvidia GPUs

There are some common issues when running docker with nvidia gpus so make sure you have all drivers up-to-date and support for OpenGL as some frameworks (like realsense-viewer) provide 
provide GUI tools that depend on it. Depending on your case it might be necessary to create the docker image on top of [a openGL specific one](https://hub.docker.com/r/nvidia/opengl) paired with
the [nvidia container toolkit](https://github.com/NVIDIA/nvidia-docker).

### Setting up Docker

To install docker on ubuntu please refer to [the official guide](https://docs.docker.com/engine/install/ubuntu/). Or run the script bellow for 
simplicity's sake (credits @goodgodgd)

```bash
# remove old versions
$ sudo apt-get remove docker docker-engine docker.io

# install required pakages
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

# add docker's official GPG key
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# verify the key, see the output looks like below
$ sudo apt-key fingerprint 0EBFCD88
pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22

# add repository
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ sudo apt-get update
$ sudo apt-get install docker-ce

# to use docker without sudo
$ sudo usermod -aG docker $USER
```

## Setup and Instalation

### Downloading

This repo has many submodules. To pull them all at once use the ``` --recurse-submodules``` option.

```
$ git clone --recurse-submodules https://github.com/ruimscarvalho98/cr-vio-bench.git
```

### Docker

After cloning this repo, you need to create the docker image as well as build whichever VIO frameworks you desire and calibration/camera tools and drivers.
Change to the cloned repo directory and run (this installs ros and most dependencies needed so it's going to take a while):

```
$ docker build . -t <NAME_FOR_THE_IMAGE>:<IMAGE_TAG>
```

Next up, create a container by running 

``` $ ./scripts/docker_run.sh <CONTAINER_NAME> <IMAGE NAME>:<IMAGE TAG>``` 

you can select which directories you want to share with the container by replacing the paths on the script:

```
# PROJECT: absolute path to main folder  
# DATASET: absolute path to folder with sample datasets (euroc/tumvi) 
# SCRIPTS: Utility scripts for running and setting up things
# OUTPUT:  Results from the VIO algorithms for benchmarking (not yet implemented)

PROJECT=/home/ruimsc98/connect_robotics/rovio-docker
DATASET=/media/ruimsc98/MASS/
SCRIPTS=/home/ruimsc98/connect_robotics/rovio-docker/scripts
OUTPUT=/home/ruimsc98/connect_robotics/rovio-docker/output
```
And you should be able to access the newly created container. If you want to run GUI applications you need to run
``` xhost +local:docker``` before starting the container.

As I always forget to do that I prefer to create an alias for this command and run it instead (optional):

```
$ echo 'alias <ALIAS_NAME>="xhost +local:docker && docker exec -it <CONTAINER_NAME> /bin/bash"' > ~/.bashrc
$ source ~/.bashrc
```

Additionally, you can add the alias command to your ~/.bashrc file (host) to open a bash shell on the container everytime you open a new terminal window.  

### Building the packages

If you haven't already done it, start and create a shell inside the container

```
$ docker start <CONTAINER_NAME>
$ xhost +local:docker && docker exec -it <CONTAINER_NAME> /bin/bash
```

Inside, the container run the script ```/work/scripts/catkin_from_scratch.sh ``` to build all packages at once. You can customise which algorithms/tools 
you want as well by uncommenting the catkin_init_ws_and_build function call.

```
# BUILD SELECTED FRAMEWORKS
catkin_init_ws_and_build "maplab" $MAPLAB_WS 1 "maplab"
catkin_init_ws_and_build "rovio"  $ROVIO_WS  1 "rovio"
catkin_init_ws_and_build "realsense" $REALSENSE_WS 1 "realsense"
catkin_init_ws_and_build "kalibr"  $KALIBR_WS  1 "kalibr"
```



## Calibration

Calibration is done using the open-source tool [Kalibr](https://github.com/ethz-asl/kalibr). It is advised to build it from source instead of 
running the cde package because of the exporting tools to formats needed in Rovio and Maplab as well as extra ROS features.

For more info on how to perform the calibration follow the guide in the official repo [here](https://github.com/ethz-asl/kalibr/wiki/calibrating-the-vi-sensor), watch this [video](https://www.youtube.com/watch?v=puNXsnrYWTY) or check out this [guide](https://support.stereolabs.com/hc/en-us/articles/360012749113-How-can-I-use-Kalibr-with-the-ZED-Mini-camera-in-ROS-) which has some helpful tips concerning the camera and target configs.

To configure the camera settings, change the launch file in ``` /work/realsense_ws/src/realsense-ros/realsense2_camera/launch/rs-camera.launch```. It is important that the unite-imu argument has 'linear_interpolation' as it's value to create a /camera/imu topic. A json config file was also added to disable
the infrared emiter to be able to use SVIO setups (credits: @engcang).

After obtaining the .yaml file from doing both the in/extrinsics and IMU calibration, an additional tool can be found under ``` /work/kalibr_ws/kalibr/aslam_offline_calibration/kalibr/python/exporters/ ``` to export to formats suitable for ROVIO(LI).


## Running Rovio

### Setup


The calibration file in ```/work/rovio_ws/src/rovio/cfg/rovio_d435i.info ``` allows for the user to toggle between doing online calibration or not, according to the value of the doVECalibration parameter

```
Common
{
        doVECalibration true;           Should the camera-IMU extrinsics be calibrated online
        depthType 1;                            Type of depth parametrization (0: normal, 1: inverse depth, 2: log, 3: hyperbolic)
        verbose false;                          Is the verbose active
}

```

A custom node is also implemented in ```/work/rovio_ws/src/rovio/launch/rovio_d435i.launch ``` remaps the subscribed topic to those published by the rs_camera node.

```
<?xml version="1.0" encoding="UTF-8"?>
<launch>
  <node pkg="rovio" type="rovio_node" name="rovio" output="screen">
  <param name="filter_config" value="$(find rovio)/cfg/rovio_d435i.info"/>
  <param name="camera0_config" value="$(find rovio)/cfg/cam1.yaml"/>
  <param name="camera0_config" value="$(find rovio)/cfg/cam2.yaml"/>
  <remap from="/cam0/image_raw" to="/camera/infra1/image_rect_raw"/>
  <remap from="/cam1/image_raw" to="/camera/infra2/image_rect_raw"/>
  <remap from="/imu0" to="/camera/imu"/>
  </node>
</launch>
```

Finally, the number of cams (to change between mono and stereo), as well as the number of features (which can have a major influence on cpu consumption) among others can be customised by changing the parameters in the CMakelists.txt file. 

Additionally, don't forget to source the files properly after making changes.


## Launching

Rovio can be launched by running the command:

```
$ roslaunch rovio rovio_d435i.launch
```
## References

[Engcang's rovio application on D435i](https://github.com/engcang/rovio-application)
> Config files for d435i and rovio

[goodgodgd's docker based vio benchmarkin](https://github.com/goodgodgd/docker-vo-bench)
> Architecture, scripts, docker based approach

[Rovio](https://github.com/ethz-asl/rovio)
> Official repo

[Maplab](https://github.com/ethz-asl/maplab)
> Official repo

[Kalibr](https://github.com/ethz-asl/kalibr/wiki/calibrating-the-vi-sensor)
> Official repo

[librealsense](https://github.com/IntelRealSense/librealsense)
>Official repo

[ros-realsense](https://github.com/IntelRealSense/realsense-ros)
>ros wrapper for d435i









