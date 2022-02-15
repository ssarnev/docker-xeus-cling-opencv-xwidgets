# 1. Starts from Miniconda3. Compiles and install numerous libraries.
#   Among them all dependencies for xeus-cling.
# 2. Compiling and installing OpenCV 4.5.5
# 3. Installs helper headers for OpenCV and xeus-cling
#   Installs ML libraries for jupyter/python
docker build . -t ssarnev/xeus-cling-opencv-xwidgets:opencv_4.5.5

