cd ./build_base
docker build . -t conda-xeus-cling:base

# Compiling and installing OpenCV 4.3.0
cd ../add_opencv
docker build . -t conda-xeus-cling:opencv_4_5_5

# Installs helper headers for OpenCV and xeus-cling
# Installs ML libraries for jupyter/python
cd ../final_setup
docker build . -t ssarnev/xeus-cling-opencv-xwidgets:opencv_4_5_5

