FROM alpine:3.3
MAINTAINER "Mark Chadwick <m.chadwick@gns.cri.nz>"

RUN apk --update upgrade && \
        apk add --update gcc libc-dev make libtirpc-dev && \
        rm -rf /var/cache/apk/*

ADD http://ds.iris.edu/pub/programs/rdseedv5.3.1.tar.gz /tmp/rdseedv5.3.1.tar
ADD rdseedv5.3.1.patch0 /tmp/rdseedv5.3.1.patch0 

RUN tar -xv -C /tmp -f /tmp/rdseedv5.3.1.tar && \
        cd /tmp/rdseedv5.3.1 && \
        patch -p1 < /tmp/rdseedv5.3.1.patch0 && \
        make clean && \
        make  && \
        cp rdseed /usr/bin

ENTRYPOINT ["/usr/bin/rdseed"]
