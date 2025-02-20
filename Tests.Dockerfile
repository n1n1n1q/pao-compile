FROM --platform=linux/amd64 ubuntu:24.04

# Update the repository sources list
RUN apt update && apt upgrade -y
RUN apt install -y gcc clang make cmake autotools-dev libboost-all-dev libeigen3-dev gdb \
    gcc-multilib valgrind libarchive-dev libtbb-dev libgsl-dev openssh-server python3 python3-pip python3-scipy \
    libomp-dev 
RUN apt clean

WORKDIR /app

CMD ["python3", "tests.py", ".",  "-cl"]