FROM ubuntu
EXPOSE 5259
STOPSIGNAL SIGKILL

# Install general build dependencies
RUN apt update
RUN apt install -y git build-essential cmake libzstd-dev libvolk-dev libglfw3-dev libfftw3-dev

# Install device-specific dependencies
RUN apt install -y libsoapysdr-dev soapysdr-module-all libairspy-dev libairspyhf-dev libhackrf-dev librtlsdr-dev libiio-dev libad9361-dev librtaudio-dev

# Clone and build
RUN mkdir /sdrpp && cd /sdrpp
RUN git clone https://github.com/AlexandreRouma/SDRPlusPlus.git /sdrpp
RUN cd /sdrpp && mkdir build && cd build && cmake .. && make && make install

# Cleanup Build dir
RUN rm -rf /sdrpp

ENTRYPOINT ["/usr/bin/sdrpp", "--server"]
