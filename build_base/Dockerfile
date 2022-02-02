FROM continuumio/miniconda3:4.10.3p1

RUN apt-get update && apt-get upgrade -yf

RUN apt-get install -y libtool pkg-config build-essential autoconf automake git cmake tmux vim python3-pip

RUN mkdir /root/source
WORKDIR /root/source

# install dependency
ADD ./build_dependencies.sh /root/source/build_dependencies.sh
RUN chmod +x ./build_dependencies.sh
RUN ./build_dependencies.sh
