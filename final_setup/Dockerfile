FROM conda-xeus-cling:opencv_4_5_5

WORKDIR /root/source
# Make the OpenCV libraries ahd headers to be accessible from within the Jupyter Notebook
ADD ./install_jupyter_opencv.sh ./install_jupyter_opencv.sh
RUN chmod +x ./install_jupyter_opencv.sh  && ./install_jupyter_opencv.sh

# Install Machine Learning libraries for Python
RUN pip3 install pandas keras matplotlib numpy opencv-python tensorflow scikit-learn

ENV C_INCLUDE_PATH="/usr/local/include:/opt/conda/include/python3.9:/opt/conda/lib/python3.9/site-packages/numpy/core/include:$C_INCLUDE_PATH"
ENV CPLUS_INCLUDE_PATH="/usr/local/include:/opt/conda/include/python3.9:/opt/conda/lib/python3.9/site-packages/numpy/core/include:$CPLUS_INCLUDE_PATH"

CMD chown jupyter -R /notebook && su jupyter -- /home/jupyter/run.sh