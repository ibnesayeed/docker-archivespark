FROM ibnesayeed/notebookspark

MAINTAINER Sawood Alam <ibnesayeed@gmail.com>

RUN curl -L -O http://l3s.de/~holzmann/archivespark-kernel.tar.gz \
    && mkdir -p /root/.ipython/kernels \
    && tar -xf archivespark-kernel.tar.gz -C /root/.ipython/kernels

ADD kernel.json /root/.ipython/kernels/archivespark/kernel.json
ADD example.ipynb /notebooks
ADD cdx /cdx
ADD warc /warc

CMD ["jupyter", "notebook", "--no-browser"]
