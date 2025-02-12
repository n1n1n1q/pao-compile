FROM --platform=linux/amd64 debian:12-slim
ENV RUNNER_URL="https://github.com/senivan/lab1-test-runs"
ENV RUNNER_TOKEN="APA5LAD7GJXZAB2BNH5AMX3HVSPIK"

# install default librairies
RUN apt update && apt upgrade -y
RUN apt install -y gcc clang make cmake autotools-dev libboost-all-dev libeigen3-dev gdb \
    gcc-multilib valgrind libarchive-dev libtbb-dev libgsl-dev openssh-server python3 python3-pip python3-scipy \
    libomp-dev curl git wget gh linux-perf && apt clean

RUN wget -O /etc/apt/sources.list.d/viva64.list \
    https://files.pvs-studio.com/etc/viva64.list
RUN wget -qO- https://files.pvs-studio.com/etc/pubkey.txt | \
    gpg --dearmor -o /etc/apt/trusted.gpg.d/viva64.gpg

RUN apt-get update && apt-get install pvs-studio -y && apt-get clean

# prepare to be github runner
RUN useradd -m runneruser && chown -R runneruser /home/runneruser
USER runneruser

# Prepare GitHub Actions runner
WORKDIR /home/runneruser/actions-runner
# download the runner
RUN curl -o actions-runner-linux-x64-2.322.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.322.0/actions-runner-linux-x64-2.322.0.tar.gz

# unpack the runner
RUN tar xzf ./actions-runner-linux-x64-2.322.0.tar.gz;chmod +x ./config.sh; 
RUN ./config.sh --url "${RUNNER_URL}" --token "${RUNNER_TOKEN}"

# prepare root
USER root
# copy entrypoint
COPY entrypoint_runner.sh /home/runneruser/actions-runner/entrypoint.sh
RUN chmod +x /home/runneruser/actions-runner/entrypoint.sh
COPY run_perf.sh /home/runneruser/actions-runner/run_perf.sh
RUN chmod +x /home/runneruser/actions-runner/run_perf.sh
# change the perf permissions
EXPOSE 22
USER runneruser
CMD ["/home/runneruser/actions-runner/entrypoint.sh"]