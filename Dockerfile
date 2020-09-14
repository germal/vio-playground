FROM nvidia/opengl:1.1-glvnd-devel-ubuntu16.04

ENV DEBIAN_FRONTEND=noninteractive

COPY scripts/ros_kinetic_setup.sh /root

RUN apt-get  update \
        && apt-get upgrade -y \
        && apt-get install -y --no-install-recommends apt-utils


#Ros installation 
RUN echo -e '\n========== installing ros (from script) ==========' \
        && chmod a+x /root/ros_kinetic_setup.sh \
	&& /root/ros_kinetic_setup.sh        



# Maplab installation
RUN echo -e '\n========== installing basic utils =======' \
        && apt-get install -y build-essential gedit nano wget curl unzip cmake git software-properties-common mesa-utils vim\
        && echo -e '\n========== install python related stufff ==========' \
        && apt-get install -y libpython2.7-dev libpython3.5-dev python-pip python3-pip python3-pandas python3-numpy \
        && echo '========== install boost ==========' \
	&& apt-get install -y libboost-all-dev \
        && echo '========== install eigen3, opencv ==========' \
        && apt-get install -y libeigen3-dev libopencv-dev \
        && echo -e '\n========== install maplab dependencies ==========' \
        && apt-get install -y autotools-dev ccache doxygen dh-autoreconf clang-format-3.8 \
        && apt-get install -y liblapack-dev libblas-dev libgtest-dev libv4l-dev libatlas3-base \
        && apt-get install -y libreadline-dev libssh2-1-dev pylint python-autopep8 python-catkin-tools \
        && apt-get install -y python-git python-setuptools python-termcolor python-wstool  \  
	&& apt-get install -y libglew-dev
        
# Openvslam dependencies
RUN echo -e '\n=========== Installing OpenVslam dependencies =====0' \
	&& apt-get install ros-kinetic-image-transport

# Ceres Dependencies (needed for vins fusion)
RUN echo '========== install ceres dependencies ==========' \
	&& apt-get install -y libeigen3-dev libsuitesparse-dev libgoogle-glog-dev libatlas-base-dev libtbb-dev \
        && apt-get install libglew-dev

# Realsense Camera drivers and software instalation
RUN echo -e '\n========== install realsense libs and dependencies ===='\
    && echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main' || tee /etc/apt/sources.list.d/realsense-public.list \
    && apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u \
    && apt-get update -qq \
    && apt-get install librealsense2-dkms --allow-unauthenticated -y \
    && apt-get install librealsense2-utils -y \
    && apt-get install librealsense2-dev --allow-unauthenticated -y \
    && apt-get -y install ros-kinetic-rgbd-launch ros-kinetic-ddynamic-reconfigure \
    && apt-get -y install libglfw3-dev 

# Realsense python wrappers
RUN python3 -m pip install --upgrade pip && python3 -m pip install pyrealsense2


# Kalibr installation 
RUN echo -e '\n========= install kalibr dependencies ==============='\
    && apt-get install -y python-setuptools python-rosinstall ipython libeigen3-dev libboost-all-dev doxygen \
        libopencv-dev ros-kinetic-vision-opencv ros-kinetic-image-transport-plugins ros-kinetic-cmake-modules \
        python-software-properties software-properties-common libpoco-dev python-matplotlib python-scipy python-git python-pip \
        ipython libtbb-dev libblas-dev liblapack-dev python-catkin-tools libv4l-dev python-igraph 

#S-MSCKF dependencies
RUN echo -e '\n=========installing S_MSCKF dependencies ============='\
	&& apt-get install -y libsuitesparse-dev ros-kinetic-tf-conversions ros-kinetic-random-numbers \
	&& apt-get install -y ros-kinetic-pcl-ros ros-kinetic-pcl-conversions

# More python stuff
RUN python3 -m pip install python-igraph --upgrade


# Additional dependencies and tools
RUN echo -e '\n ====== install gazebo ============================='\
        && sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
        && wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
        && apt-get update && apt-get install -y \
        gazebo7 libignition-math2-dev \
        ros-kinetic-gazebo-ros-pkgs ros-kinetic-gazebo-ros-control 

#IMU tools
RUN apt-get install libdw-dev ros-kinetic-cv-bridge -y



