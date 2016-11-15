FROM jupyter/notebook

MAINTAINER Sawood Alam <ibnesayeed@gmail.com>

RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:openjdk-r/ppa -y \
    && apt-get update && apt-get install -y openjdk-8-jre

RUN curl -L -O http://archive.apache.org/dist/spark/spark-2.0.2/spark-2.0.2-bin-hadoop2.7.tgz \
    && mkdir /spark \
    && tar -xf spark-2.0.2-bin-hadoop2.7.tgz --strip-components=1 -C /spark \
    && rm spark-2.0.2-bin-hadoop2.7.tgz

RUN curl -L -O http://l3s.de/~holzmann/archivespark2-kernel.tar.gz \
    && mkdir -p /root/.ipython/kernels \
    && tar -xf archivespark2-kernel.tar.gz -C /root/.ipython/kernels \
    && rm archivespark2-kernel.tar.gz \
    && mv /root/.ipython/kernels/archivespark2-kernel /root/.ipython/kernels/archivespark

COPY kernel.json /root/.ipython/kernels/archivespark/kernel.json
COPY example.ipynb /notebooks/
COPY cdx /cdx
COPY warc /warc

CMD ["jupyter", "notebook", "--no-browser"]
