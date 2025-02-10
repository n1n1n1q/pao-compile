FROM --platform=linux/amd64 debian:12-slim

# install default librairies
RUN apt update && apt upgrade -y
RUN apt install -y gcc clang make cmake autotools-dev libboost-all-dev libeigen3-dev gdb \
    gcc-multilib valgrind libarchive-dev libtbb-dev libgsl-dev openssh-server python3 python3-pip python3-scipy \
    libomp-dev curl

# installing perf
RUN apt install -y linux-perf

# prepare to be github runner
RUN mkdir actions-runner && cd actions-runner

# download the runner
RUN curl -o actions-runner-linux-x64-2.322.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.322.0/actions-runner-linux-x64-2.322.0.tar.gz

# unpack the runner
RUN tar xzf ./actions-runner-linux-x64-2.322.0.tar.gz

# clean the cache
RUN apt clean


ENV RUNNER_URL=""
ENV RUNNER_TOKEN=""

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22

CMD ["RUN ./config.sh --url ",${RUNNER_URL},  "--token ",${RUNNER_TOKEN}, "--unattended"]