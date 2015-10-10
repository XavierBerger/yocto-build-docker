FROM ubuntu:precise

RUN useradd -d /yocto-edison-src -s /bin/bash bitbake

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# From http://download.intel.com/support/edison/sb/edisonbsp_ug_331188007.pdf
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential git diffstat gawk chrpath texinfo libtool gcc-multilib \
    # missing from the doc
    wget libsdl1.2-dev

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    # For flashing
    dfu-util \
    vim curl

VOLUME /yocto-edison-src
VOLUME /yocto-edison-build
VOLUME /bitbake/download
VOLUME /bitbake/sstate

ADD download-source /bin/download-source
ADD setup-source /bin/setup-source
ADD build-image /bin/build-image

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#USER bitbake
# RUN chown bitbake:bitbake /yocto-edison-src /bitbake/download /bitbake/sstate
CMD /bin/download-source && /bin/setup-source && /bin/build-image 
