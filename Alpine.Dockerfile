FROM --platform=amd64 alpine:3.14

# Update the repository sources list
RUN sed -i 's/^#//g' /etc/apk/repositories
RUN apk update && apk upgrade
RUN apk add gcc clang make automake cmake boost-dev eigen gdb \
    valgrind libarchive libtbb gsl openssh python3 py3-pip py3-scipy \
    git github-cli libgomp 

RUN ssh-keygen -A

RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/Port 22/Port 22/' /etc/ssh/sshd_config

ENV SSH_PASSWORD=root

COPY ./entrypoint_alpine.sh /entrypoint_alpine.sh
RUN chmod +x /entrypoint_alpine.sh

EXPOSE 22

CMD ["/entrypoint_alpine.sh"]