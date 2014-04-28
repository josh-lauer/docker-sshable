FROM ubuntu:saucy
MAINTAINER Michael Orr <michael@cloudspace.com>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server supervisor
RUN mkdir /var/run/sshd
RUN echo 'root:updog' | chpasswd
ADD config_files/ssh_config /etc/ssh/ssh_config
ADD config_files/sshd_config /etc/ssh/sshd_config
ADD config_files/supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
RUN sudo service ssh restart

EXPOSE 22
CMD ["exec supervisord -n"]