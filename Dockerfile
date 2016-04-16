FROM alpine:3.3
MAINTAINER "Mark Chadwick <m.chadwick@gns.cri.nz>"

RUN apk --update upgrade && \
        apk add --update gcc libc-dev make libtirpc-dev && \
        rm -rf /var/cache/apk/*

ADD http://ds.iris.edu/pub/programs/rdseedv5.3.1.tar.gz /tmp/rdseedv5.3.1.tar

RUN tar -xv -C /tmp -f /tmp/rdseedv5.3.1.tar && \
        cd /tmp/rdseedv5.3.1 && \
        make clean && \
        find . -depth -name makefile -exec sed -i -e 's#cc#gcc -I/usr/include/tirpc#' {} \; && \
        find . -depth -name Makefile -exec sed -i -e 's#-lnsl#-ltirpc#g' {} \; && \
        find . -depth -name makefile -exec sed -i -e 's#ggcc -I/usr/include/tirpc##' {} \; && \
        make && \
        cp rdseed /usr/bin

ENTRYPOINT ["/usr/bin/rdseed"]
