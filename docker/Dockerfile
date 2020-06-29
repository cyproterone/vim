FROM ubuntu:latest


RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt update && \
    apt install -y && \
    neovim \
    git curl \
    python3 python3-pip \
    nodejs


COPY . /root/.config/nvim
WORKDIR /root/.config/nvim
RUN ./bin/nvim-init && \
    ./bin/nvim-pip && \
    ./bin/nvim-npm
