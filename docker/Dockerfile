FROM ubuntu:latest


ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt update && \
    apt install -y \
    neovim \
    git curl \
    python3 python3-pip \
    nodejs npm


COPY . /root/.config/nvim
WORKDIR /root/.config/nvim
ENV XDG_CONFIG_HOME=/root/.config \
    FZF_DEFAULT_OPTS=1
RUN ./bin/nvim-init && \
    ./bin/nvim-pip && \
    ./bin/nvim-npm
