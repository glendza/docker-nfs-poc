FROM python:3.11.4-slim-bookworm

# Installing deps
RUN pip install --upgrade pip
RUN pip install flask

USER root

# Installing mounting deps
RUN apt-get update \
    && apt-get -y install sudo \
    && apt-get install passwd \
    && apt-get install nfs-common -y \
    && apt-get clean

# Creating a sudo user
RUN useradd -ms /bin/bash mounter
RUN echo "mounter:m0unter" | chpasswd
RUN usermod -aG sudo mounter

# Limit permissions on "mount" command - only mounter can do it
RUN chmod go-rwx /usr/bin/mount

# Creating user / home
RUN useradd -ms /bin/bash flask
ARG HOME=/home/flask

# Copying the code
WORKDIR ${HOME}
RUN mkdir -p ${HOME}/app
ADD main.py ${HOME}/app/main.py

# Mounting-related stuff
ADD mount-nfs.sh ${HOME}/mount-nfs.sh
RUN chmod u+x ${HOME}/mount-nfs.sh

# Runtime stuff
USER flask
ENV FLASK_APP ${HOME}/app/main.py
CMD ["flask", "run"]
