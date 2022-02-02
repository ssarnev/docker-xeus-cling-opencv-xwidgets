
#Upgrade pip
pip install --upgrade pip

# Install cmake
pip install cmake

# json
#git clone -b v3.10.5 https://github.com/nlohmann/json.git --depth 1
git clone -b v3.9.1 https://github.com/nlohmann/json.git --depth 1
cd json && mkdir build && cd build && cmake ../ && make -j4 && make install
cd ../../

# xtl
# git clone -b 0.7.4 https://github.com/xtensor-stack/xtl.git --depth 1
git clone -b 0.7.0 https://github.com/xtensor-stack/xtl.git --depth 1
cd xtl && mkdir build && cd build && cmake ../ && make -j4 && make install
cd ../../

# openssl
git clone -b OpenSSL_1_1_1g https://github.com/openssl/openssl.git --depth 1
cd openssl && ./config && make -j4 && make test && make install
cd ../

# libzmq (ZeroMQ)
#git clone -b v4.3.4 https://github.com/zeromq/libzmq.git --depth 1
git clone -b v4.2.5 https://github.com/zeromq/libzmq.git --depth 1
cd libzmq && mkdir build && cd build && cmake ../ && make -j4 && make install
cd ../../

# cppzmq
git clone -b v4.7.1 https://github.com/zeromq/cppzmq.git --depth 1
#cd cppzmq && mkdir build && cd build && cmake ../ && make -j4 && make install
# There is an error occuring during the compilation of the tests. That is why they are turned off
cd cppzmq && mkdir build && cd build && cmake -DCPPZMQ_BUILD_TESTS=OFF ../ && make -j4 && make install
cd ../../

# xeus dependancy. Without it I am getting a CMake error - Could NOT find LibUUID (missing: LibUUID_LIBRARY LibUUID_INCLUDE_DIR)
apt-get install uuid-dev

# install xeus
#git clone -b 2.3.1 https://github.com/jupyter-xeus/xeus.git --depth 1
git clone -b 2.1.1 https://github.com/jupyter-xeus/xeus.git --depth 1
cd xeus && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=Release ../ && make -j4 && make install
cd ../../

git clone -b v1.8.1 https://github.com/zeux/pugixml.git --depth 1
cd pugixml && mkdir build && cd build && \
    cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D BUILD_SHARED_LIBS=ON \
        ../ && \
    make -j4 && make install
cd ../../

# install cxxopts
git clone -b v2.1.1 https://github.com/jarro2783/cxxopts --depth 1
cd cxxopts && mkdir build && cd build && cmake ../ && make -j4 && make install
cd ../../


# Install Jupyter laboratory
conda install jupyterlab -y -c conda-forge


# Install precompiled xeus-cling with the corresponding kernels for C++ 11, 14 and 17
conda install -y xeus-cling -c conda-forge

# Install xwidgets
conda install -y -q ipywidgets -c conda-forge
conda install -y -q yxwidgets -c conda-forge


# Compile and install xproperty
cd /root/source
git clone -b 0.11.0 https://github.com/jupyter-xeus/xproperty.git --depth 1
cd xproperty && mkdir build && cd build && cmake ../ && make -j4 && make install

# Compile and install xwidgets
cd /root/source
git clone -b 0.26.1 https://github.com/jupyter-xeus/xwidgets.git --depth 1
cd xwidgets && mkdir build && cd build && cmake ../ && make -j4 && make install
make install


