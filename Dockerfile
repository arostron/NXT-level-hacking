FROM i386/ubuntu 

# install NBC dependency
RUN apt-get update
RUN apt-get install libusb-0.1-4

# install NBC into path 
COPY ./resources/tars/nbc-1.0.1.b35.tgz /tmp
WORKDIR /tmp
RUN tar xf nbc-1.0.1.b35.tgz 
RUN cp nxt/nbc /bin
RUN chmod +x /bin/nbc
