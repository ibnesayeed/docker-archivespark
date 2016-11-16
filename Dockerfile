FROM jupyter/pyspark-notebook

MAINTAINER Sawood Alam <ibnesayeed@gmail.com>

RUN conda install jupyterlab

USER root

RUN apt-get update && apt-get install -y --no-install-recommends curl

# RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
# RUN apt-get update && apt-get install -y software-properties-common \
#    && add-apt-repository ppa:openjdk-r/ppa -y \
#    && apt-get update && apt-get install -y openjdk-8-jre

# For some reason above method is installing Java 7
RUN echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L -O http://archive.apache.org/dist/spark/spark-2.0.2/spark-2.0.2-bin-hadoop2.7.tgz \
    && mkdir /spark \
    && tar -xf spark-2.0.2-bin-hadoop2.7.tgz --strip-components=1 -C /spark \
    && rm spark-2.0.2-bin-hadoop2.7.tgz

RUN curl -L -O http://l3s.de/~holzmann/archivespark2-kernel.tar.gz \
    && mkdir -p /home/jovyan/.ipython/kernels \
    && tar -xf archivespark2-kernel.tar.gz -C /home/jovyan/.ipython/kernels \
    && rm archivespark2-kernel.tar.gz \
    && mv /home/jovyan/.ipython/kernels/archivespark2-kernel /home/jovyan/.ipython/kernels/archivespark

COPY kernel.json /home/jovyan/.ipython/kernels/archivespark/kernel.json
COPY example.ipynb /home/jovyan/work/
COPY cdx /cdx
COPY warc /warc

USER $NB_USER

CMD ["start.sh", "jupyter", "lab", "--no-browser"]
