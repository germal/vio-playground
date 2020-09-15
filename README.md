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
simplicity's sake (credits @goodgodgd).

```
# remove old versions
sudo apt-get remove docker docker-engine docker.io

# install required pakages
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

#add docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# verify the key, see the output looks like below
sudo apt-key fingerprint 0EBFCD88

# pub   4096R/0EBFCD88 2017-02-22
#      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
# uid                  Docker Release (CE deb) <docker@docker.com>
# sub   4096R/F273FCD8 2017-02-22

# add repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce

# to use docker without sudo
sudo usermod -aG docker $USER
```
or simply run:

```
cd <PATH_TO_VIO_PLAYGROUND>
./scripts/docker_install
```
## Setup and Instalation

### Downloading

This repo has many submodules. To pull them all at once use the ``` --recurse-submodules``` option.

```
git clone --recurse-submodules https://github.com/ruimscarvalho98/cr-vio-bench.git
```

### Docker

After cloning this repo, you need to create the docker image as well as build whichever VIO frameworks you desire and calibration/camera tools and drivers.
Change to the cloned repo directory and run (this installs ros and most dependencies needed so it's going to take a while):

```
docker build . -t <NAME_FOR_THE_IMAGE>:<IMAGE_TAG>
```

Next up, create a container by running 

``` ./scripts/docker_run.sh <CONTAINER_NAME> <IMAGE NAME>:<IMAGE TAG>``` 

you can select which directories you want to share with the container by replacing the paths on the script:

```
# PROJECT: absolute path to main folder  
# DATASET: absolute path to folder with sample datasets (euroc/tumvi)
# OUTPUT:  Results from the VIO algorithms for benchmarking

PROJECT=/home/ruimsc98/vio-test/vio-playground
DATASET=/media/ruimsc98/MASS/dataset
OUTPUT=/home/ruimsc98/MASS/output
```
After running you should be able to access the newly created container. If you want to run GUI applications you need to run
``` xhost +local:docker``` before starting the container.

As I always forget to do that I prefer to create an alias for this command and run it instead (optional):

```
echo 'alias <ALIAS_NAME>="xhost +local:docker && docker exec -it <CONTAINER_NAME> /bin/bash"' > ~/.bashrc
source ~/.bashrc
```

Additionally, you can add the alias command to your ~/.bashrc file (host) to open a bash shell on the container everytime you open a new terminal window.  

### Building the packages

If you haven't already done it, start and create a shell inside the container

```
docker start <CONTAINER_NAME>
xhost +local:docker && docker exec -it <CONTAINER_NAME> /bin/bash
```
Inside the container, the first thing you probably want to do is run these convenience scripts to setup the ROS environment and define aliases to source workspaces faster (this is optional and you can set this up the way you see fit).

```
/scripts/setup_ros_env.sh
/scripts/define_all_alias.sh
```

Next up, build the dependencies from source (Eigen, openCV, ceres and pangolin) as you'll most likely need them:

```
/scripts/install_all_dependencies.sh
```

Alternatively, you can run the individual scripts to choose only the libraries you need.

Now you can build the algorithms you want by running the respective script.


## Calibration

Calibration is done using the open-source tool [Kalibr](https://github.com/ethz-asl/kalibr) and IMU_Utils. It is advised to build Kalibr from source instead of 
running the cde package because of the exporting tools to formats needed in Rovio and Maplab as well as extra ROS features.

You can build the calibration tools by running the script
```
/scripts/install_calibration_tools.sh
```

For more information on how to perform the calibration please check out the [wiki](https://github.com/ruimscarvalho98/vio-playground/wiki/Calibration)

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









