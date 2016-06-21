# ArchiveSpark

[ArchiveSpark](https://github.com/helgeho/ArchiveSpark) is a framework that facilitates access to Web Archives and enables easy data extraction as well as derivation. This repository makes ArchiveSpark available as a [Docker](https://www.docker.com/) image. We made it easy to run ArchiveSpark as a Docker container without the need of a Hadoop cluster and without the need of installing and configuring various dependencies. To get started, run the following command (assuming that Docker is installed on the machine):

```
$ docker run --rm -it -p 8888:8888 ibnesayeed/archivespark
```

Then open a browser and access the Notebook at `http://localhost:8888/`. There should be an example notebook (`example.ipynb`) available to play with the included example `CDX` and `WARC` files.

To run the container with `CDX` and `WARC` files other than included examples, mount corresponding directories in the container at run time. Additionally, to make the notebooks available outside of the container, mount a notebook directory of the host machine with write permissions. Following command illustrates the usage:

```
$ docker run --rm -it -p 8888:8888 -v /path/to/cdx:/cdx -v /path/to/warc:/warc -v /path/to/notebook:/notebook ibnesayeed/archivespark
```
