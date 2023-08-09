##############################################################################
# Base Image : Pytorch
##############################################################################

FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

##############################################################################
# Arguments
##############################################################################

ARG USERNAME=yuzhong
ARG USERPASSWD=ubuntu
ARG USERID=$UID
ARG SHELL=bash

##############################################################################
# Label
##############################################################################

LABEL org.opencontainers.image.authors="yuzhong"
LABEL shell="${SHELL}"

##############################################################################
# Set environment variables
##############################################################################

ENV TERM=xterm-256color
ENV SHELL=/bin/${SHELL}
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV USERNAME=${USERNAME}
ENV PATH=${PATH}:~/.local/bin

##############################################################################
# Install packages
##############################################################################

RUN apt update && \
    apt install -y \
    sudo \
    vim \
    curl \
    wget \
    tmux \
    htop \
    git \
    net-tools

RUN apt autoremove -y && \
    apt clean -y 

RUN pip install \
    pandas \
    flexgen \
    wandb

##############################################################################
# Set timezone (Taipei)
##############################################################################

RUN DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends tzdata
RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata 

##############################################################################
# Add new user (Passwordless with sudo)
##############################################################################

RUN useradd -ms /bin/${SHELL} ${USERNAME} && \
    sudo adduser ${USERNAME} sudo && \
    echo "${USERNAME}:${USERPASSWD}" | chpasswd && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers 

##############################################################################
# Set default Shell & User & Working Directory
##############################################################################

SHELL ["/bin/${SHELL}", "-c"]
USER ${USERNAME}
WORKDIR /home/${USERNAME}