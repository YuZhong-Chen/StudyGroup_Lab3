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
ARG SHELL=zsh

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
    git-extras \
    zsh \
    gnupg2 \
    net-tools

RUN apt autoremove -y && \
    apt clean -y 

RUN pip install \
    pandas \
    ipykernel \
    ipython \
    pytorchcv \
    torchinfo \
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
# Set default User & Working Directory
##############################################################################

USER ${USERNAME}
WORKDIR /home/${USERNAME}

##############################################################################
# Install oh-my-zsh
##############################################################################

RUN git clone https://github.com/ohmyzsh/ohmyzsh.git /home/${USERNAME}/.oh-my-zsh && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/home/${USERNAME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-/home/${USERNAME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
COPY ./settings/.zshrc /home/${USERNAME}/.zshrc 
COPY ./settings/theme/jovial.zsh-theme /home/${USERNAME}/.oh-my-zsh/custom/themes/jovial.zsh-theme
COPY ./settings/theme/jovial.plugin.zsh /home/${USERNAME}/.oh-my-zsh/custom/plugins/jovial/jovial.plugin.zsh

##############################################################################
# Set tmux plugins
##############################################################################

RUN git clone https://github.com/tmux-plugins/tpm /home/${USERNAME}/.tmux/plugins/tpm
COPY ./settings/.tmux.conf /home/${USERNAME}/.tmux.conf
RUN /home/${USERNAME}/.tmux/plugins/tpm/bin/install_plugins

##############################################################################
# Default command
##############################################################################

SHELL ["/bin/${SHELL}", "-c"]
CMD ["zsh"]