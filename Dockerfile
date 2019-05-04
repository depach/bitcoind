FROM ubuntu:bionic

RUN apt-get update; \
    apt-get install -y software-properties-common; \
    apt-add-repository ppa:bitcoin/bitcoin; \
    apt-get update; \
	apt-get install -y \
		build-essential \
		libtool \
		autotools-dev \
		automake \
		pkg-config \
		libssl-dev \
        libevent-dev \
		libboost-all-dev \
		wget \
		bsdmainutils \
        git-core \
        libdb4.8-dev \
        libdb4.8++-dev \
		nano
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root/
RUN git clone --branch v0.17.1 https://github.com/bitcoin/bitcoin.git
WORKDIR /root/bitcoin
RUN ./autogen.sh ; ./configure ; make ; make install ; make clean
WORKDIR /root/
RUN rm -fr bitcoin
RUN mkdir /root/.bitcoin

# ADD ./bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
# RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
# ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]