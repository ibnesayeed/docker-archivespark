FROM ibnesayeed/notebookspark

MAINTAINER Sawood Alam <ibnesayeed@gmail.com>

ADD archivespark /root/.ipython/kernels/archivespark
ADD kernel.json /root/.ipython/kernels/archivespark/kernel.json
ADD example.ipynb /notebooks
ADD cdx /cdx
ADD warc /warc

CMD ["jupyter", "notebook", "--no-browser"]
