FROM ubuntu:saucy
MAINTAINER Michael Orr <michael@cloudspace.com>

RUN apt-get update
# Install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:updog' | chpasswd
ADD config_files/ssh_config /etc/ssh/ssh_config
ADD config_files/sshd_config /etc/ssh/sshd_config
RUN sudo service ssh restart

EXPOSE 22