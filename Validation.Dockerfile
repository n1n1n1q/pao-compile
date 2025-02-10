FROM --platform=linux/amd64 debian:12-slim
ENV RUNNER_URL="https://github.com/senivan/lab1-test-runs"
ENV RUNNER_TOKEN="APA5LAGQJQUU52B6IQUO5Q3HVJZ6Y"
# install default librairies
RUN apt update && apt upgrade -y
RUN apt install -y gcc clang make cmake autotools-dev libboost-all-dev libeigen3-dev gdb \
    gcc-multilib valgrind libarchive-dev libtbb-dev libgsl-dev openssh-server python3 python3-pip python3-scipy \
    libomp-dev curl git wget && apt clean

# installing perf
RUN apt install -y linux-perf

# we also need to install vps-studio
# Install from the oficial tutorial: https://pvs-studio.com/en/docs/manual/0039/
RUN wget -qO- https://files.pvs-studio.com/etc/pubkey.txt | \
gpg --dearmor -o /etc/apt/trusted.gpg.d/viva64.gpg

RUN wget -O /etc/apt/sources.list.d/viva64.list \
https://files.pvs-studio.com/etc/viva64.list

RUN apt-get update
RUN apt-get install pvs-studio -y && apt-get clean

# prepare to be github runner
RUN mkdir actions-runner && cd actions-runner

# download the runner
RUN curl -o actions-runner-linux-x64-2.322.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.322.0/actions-runner-linux-x64-2.322.0.tar.gz

# unpack the runner
RUN tar xzf ./actions-runner-linux-x64-2.322.0.tar.gz

RUN ./config.sh --url ${RUNNER_URL} --token ${RUNNER_TOKEN}


EXPOSE 22
CMD ["./run.sh"]