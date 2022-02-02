cd /root/source

git clone -b 4.5.5 https://github.com/opencv/opencv_contrib.git --depth 1
git clone -b 4.5.5 https://github.com/opencv/opencv.git --depth 1

mkdir opencv_build__4.5.5 && cd opencv_build__4.5.5

cmake CMAKE_BUILD_TYPE=Release \
  -DBUILD_EXAMPLES=ON \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DOPENCV_GENERATE_PKGCONFIG=ON \
  -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
  ../opencv

make -j6 && make install

rm -rf /root/source/*