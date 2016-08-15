FROM alpine:3.3
MAINTAINER "Mark Chadwick <m.chadwick@gns.cri.nz>"

ADD rdseedv5.3.1.patch0 /tmp/rdseedv5.3.1.patch0 
RUN apk --update upgrade && \
        apk add --update curl gcc libc-dev make libtirpc-dev && \
        curl --output /tmp/rdseedv5.3.1.tar.gz http://ds.iris.edu/pub/programs/rdseedv5.3.1.tar.gz && \
        tar -xvz -C /tmp -f /tmp/rdseedv5.3.1.tar.gz && \
        cd /tmp/rdseedv5.3.1 && \
        patch -p1 < /tmp/rdseedv5.3.1.patch0 && \
        make clean && \
        make  && \
        cp rdseed /usr/bin && \
        apk del curl gcc make && \
        rm -f /tmp/rdseedv5.3.1.patch0 && \
        rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/rdseed"]
