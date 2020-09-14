mkdir -p /work/dependencies 

echo "############ Installing eigen...             ##############"
sleep 2
chmod a+x /scripts/install_eigen
/scripts/install_eigen.sh

echo "############ Installing openCV from source... ##############"
sleep 5
chmod a+x /scripts/install_openCV_source.sh
/scripts/install_openCV_source.sh

echo "############ Installing Ceres                 ##############"
sleep 5
chmod a+x /scripts/install_ceres.sh
/scripts/install_ceres.sh

echo "############# Installing pangolin...              #############"
sleep 5
chmod a+x /scripts/install_pangolin.sh
/scripts/install_pangolin.sh

