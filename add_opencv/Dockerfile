FROM conda-xeus-cling:base

ADD ./install_opencv_4_5_5.sh /root/install_opencv_4_5_5.sh
RUN chmod +x /root/install_opencv_4_5_5.sh && /root/install_opencv_4_5_5.sh

CMD chown jupyter -R /notebook && su jupyter -- /home/jupyter/run.sh