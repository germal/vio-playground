CERES_DIR='/work/dependencies/ceres'
if [ -d "$CERES_DIR" ]; then
    read -p "Directory /work/dependencies/ceres already exists. Do you wish to overwrite it? (y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then   
        rm -rf $CERES_DIR 
    else
        echo "Ceres installation aborted"
        exit 0
    fi  
fi

echo "CREATING $CERES_DIR"
mkdir -p $CERES_DIR
cd $CERES_DIR
echo "Downloading files"
sleep 1
wget ceres-solver.org/ceres-solver-1.14.0.tar.gz

echo "Unpacking..."
sleep 1
tar xvf ceres-solver-1.14.0.tar.gz
rm xvf ceres-solver-1.14.0.tar.gz
cd ceres-solver-1.14.0

mkdir build
cd build
cmake ..
make -j4
make test
make install 
