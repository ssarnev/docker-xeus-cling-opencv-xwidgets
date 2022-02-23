# Build the base
###============--------------

FROM continuumio/miniconda3:4.10.3p1

RUN apt-get update && apt-get upgrade -yf

RUN apt-get install -y libtool pkg-config build-essential autoconf automake git cmake tmux vim python3-pip

WORKDIR /root/source

# install dependency
ADD ./build_dependencies.sh /root/source/build_dependencies.sh
RUN chmod +x ./build_dependencies.sh
RUN ./build_dependencies.sh


# Compile and install OpenCV
###============--------------

ARG OPENCV_VERSION=4.5.5

RUN git clone -b $OPENCV_VERSION https://github.com/opencv/opencv_contrib.git --depth 1
RUN git clone -b $OPENCV_VERSION https://github.com/opencv/opencv.git --depth 1

WORKDIR /root/source/opencv_build__$OPENCV_VERSION

RUN  apt-get update -y && apt-get install -y \
   libgstreamer1.0-0 \
   gstreamer1.0-plugins-base \
   gstreamer1.0-plugins-good \
   gstreamer1.0-plugins-bad \
   gstreamer1.0-plugins-ugly \
   gstreamer1.0-libav \
   gstreamer1.0-tools \
   libgstreamer1.0-dev \
   libgstreamer-plugins-base1.0-dev
   
RUN  apt-get update -y && apt-get install -y  pkg-config \
   zlib1g-dev  libwebp-dev \
   libtbb2 libtbb-dev  \
   libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
   cmake

RUN cmake \
# Compiler params
   -D CMAKE_BUILD_TYPE=RELEASE \
   -D CMAKE_INSTALL_PREFIX=/usr/local \
   # No examples
   -D INSTALL_PYTHON_EXAMPLES=NO \
   -D INSTALL_C_EXAMPLES=NO \
   # Support
   -D WITH_IPP=NO \
   -D WITH_1394=NO \
   -D WITH_LIBV4L=NO \
   -D WITH_V4l=YES \
   -D WITH_TBB=YES \
   -D WITH_FFMPEG=YES \
   -D WITH_GPHOTO2=YES \
   -D WITH_GSTREAMER=YES \
   # NO doc test and other bindings
   -D BUILD_DOCS=NO \
   -D BUILD_TESTS=NO \
   -D BUILD_PERF_TESTS=NO \
   -D BUILD_EXAMPLES=NO \
   -D BUILD_opencv_java=NO \
   -D BUILD_opencv_python2=NO \
   -D BUILD_ANDROID_EXAMPLES=NO \
   # Build Python3 bindings only
   -D PYTHON3_LIBRARY=`find /usr -name libpython3.so` \
   -D PYTHON_EXECUTABLE=`which python3` \
   -D PYTHON3_EXECUTABLE=`which python3` \
   -D OPENCV_GENERATE_PKGCONFIG=ON \
   -D BUILD_opencv_python3=YES \
   ../opencv

RUN make -j`grep -c '^processor' /proc/cpuinfo` && make install

RUN rm -rf /root/source/*


# Final setup
###============--------------
# - Create a header for the OpenCV include files and libraries to be used from inside xeus-cling
# - Install common ML, visualization and math libraries for Python
# - Add paths to the Python3 headers to resolve dependencies.

# Make the OpenCV libraries ahd headers to be accessible from within the Jupyter Notebook
ADD ./install_jupyter_opencv.sh ./install_jupyter_opencv.sh
RUN chmod +x ./install_jupyter_opencv.sh  && ./install_jupyter_opencv.sh

ENV C_INCLUDE_PATH="/usr/local/include:/opt/conda/include/python3.9:/opt/conda/lib/python3.9/site-packages/numpy/core/include:$C_INCLUDE_PATH"
ENV CPLUS_INCLUDE_PATH="/usr/local/include:/opt/conda/include/python3.9:/opt/conda/lib/python3.9/site-packages/numpy/core/include:$CPLUS_INCLUDE_PATH"

WORKDIR /workspace
COPY /workspace /workspace

WORKDIR /content
COPY /workspace /content


# The default command
###============--------------

CMD jupyter notebook --allow-root --ip=0.0.0.0 --port=8888
