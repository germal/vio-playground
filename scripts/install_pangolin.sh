PANGOLIN_DIR='/work/dependencies/Pangolin'
if [ -d "$PANGOLIN_DIR" ]; then
    read -p "Directory /work/dependencies/Pangolin already exists. Do you wish to overwrite it? (y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then   
        rm -rf $PANGOLIN_DIR 
    else
        echo "Pangolin installation aborted"
        exit 0
    fi  
fi

mkdir -p $PANGOLIN_DIR
cd $PANGOLIN_DIR
git clone https://github.com/stevenlovegrove/Pangolin.git $PANGOLIN_DIR
git checkout ad8b5f83222291c51b4800d5a5873b0e90a0cf81
mkdir build && cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    ..
make -j4
make install
