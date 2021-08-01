FROM alpine:latest

# don't run as root
# credits go to: https://gist.github.com/avishayp/33fcee06ee440524d21600e2e817b6b7
ARG USER=default
ENV HOME /home/$USER

# install sudo as root
RUN apk add --update sudo

# add new user
RUN adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME

RUN sudo apk add --no-cache alpine-sdk util-linux findutils python3 py3-pip wget unzip docker jq git bash sudo

# Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# TASKFILE
RUN curl -sL https://taskfile.dev/install.sh | sh

# TFENV
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv \
    && sudo ln -s ~/.tfenv/bin/* /usr/local/bin

# TGENV
RUN git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv \
    && sudo ln -s ~/.tgenv/bin/* /usr/local/bin

# Terraform and Terragrunt
RUN tfenv install 0.12.28 \
    && tfenv install 1.0.3 \
    && tgenv install 0.23.31 \
    && tgenv install 0.31.3
