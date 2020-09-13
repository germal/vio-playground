EIGEN_DIR='/work/dependencies/eigen'
if [ -d "$EIGEN_DIR" ]; then
    read -p "Directory $EIGEN_DIR already exists. Do you wish to overwrite it? (y/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then   
        rm -rf $EIGEN_DIR 
    else
        echo "EIGEN installation aborted"
        exit 0
    fi  
fi

mkdir -p $EIGEN_DIR
cd $EIGEN_DIR
wget https://gitlab.com/libeigen/eigen/-/archive/3.3.4/eigen-3.3.4.tar.bz2
tar xf eigen-3.3.4.tar.bz2
rm -rf eigen-3.3.4.tar.bz2
cd eigen-3.3.4
mkdir -p build && cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    ..
make -j4
make uninstall