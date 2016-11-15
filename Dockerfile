FROM jupyter/notebook

MAINTAINER Sawood Alam <ibnesayeed@gmail.com>

RUN apt-get update && apt-get install -y default-jre

RUN curl -L -O http://archive.apache.org/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz \
    && mkdir /spark \
    && tar -xf spark-1.6.1-bin-hadoop2.6.tgz --strip-components=1 -C /spark \
    && rm spark-1.6.1-bin-hadoop2.6.tgz

RUN curl -L -O http://l3s.de/~holzmann/archivespark-kernel.tar.gz \
    && mkdir -p /root/.ipython/kernels \
    && tar -xf archivespark-kernel.tar.gz -C /root/.ipython/kernels \
    && rm archivespark-kernel.tar.gz

ADD kernel.json /root/.ipython/kernels/archivespark/kernel.json
ADD example.ipynb /notebooks/
ADD cdx /cdx
ADD warc /warc

CMD ["jupyter", "notebook", "--no-browser"]
