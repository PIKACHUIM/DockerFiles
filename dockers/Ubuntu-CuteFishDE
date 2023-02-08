# Images ------------------------------------------------------
ARG OS_VERSION=latest
ARG OS_SYSTEMS=ubuntu
FROM ubuntu:${OS_VERSION}
# ARGS --------------------------------------------------------
ARG OS_MESSAGE=""
ARG OS_VERSION
# Message -----------------------------------------------------
MAINTAINER Pikachu Ren <pikachuim@qq.com>
LABEL OSType=${OS_SYSTEMS}
LABEL Version=${OS_VERSION}
LABEL Description=${OS_MESSAGE}
# Set UP APT Sources ------------------------------------------
RUN rm /etc/apt/sources.list
copy apt-repos/ubuntu-${OS_VERSION}-163.list \
		 /etc/apt/sources.list
# Install Softwares -------------------------------------------
RUN apt update
RUN apt install -y openssh-server \
 && apt install -y sudo vim nano  \
 && mkdir -p /var/run/sshd \
 && mkdir -p /root/.ssh/
# Allow SSH PAM & Password Login ------------------------------
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/' \
			/etc/pam.d/sshd
RUN echo "PermitRootLogin yes" > /etc/ssh/sshd_config
COPY ssh-login/authorized_keys /root/.ssh/
COPY start-run/run.sh /run.sh
RUN chmod +x /run.sh
# Port Mapping ------------------------------------------------
EXPOSE 22/tcp
CMD ["/run.sh"]
