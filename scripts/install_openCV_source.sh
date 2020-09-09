OPENCV_DIR='/work/dependencies/opencv'
if [ -d "$OPENCV_DIR" ]; then
    read -p "Directory $OPENCV_DIR already exists. Do you wish to overwrite it? (y/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then   
        rm -rf $OPENCV_DIR 
    else
        echo "OPENCV installation aborted"
        exit 0
    fi  
fi

mkdir -p $OPENCV_DIR
cd $OPENCV_DIR
wget https://github.com/opencv/opencv/archive/3.4.0.zip
unzip -q 3.4.0.zip
rm -rf 3.4.0.zip
cd opencv-3.4.0
mkdir -p build && cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DENABLE_CXX11=ON \
    -DBUILD_DOCS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_JASPER=OFF \
    -DBUILD_OPENEXR=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
    -DWITH_EIGEN=ON \
    -DWITH_FFMPEG=ON \
    -DWITH_OPENMP=ON \
    ..
make -j4
make install
