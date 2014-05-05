FROM ubuntu:trusty
MAINTAINER Josh Lauer <michael@cloudspace.com>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server supervisor
RUN mkdir -p /var/run/sshd
ADD config_files/ssh_config /etc/ssh/ssh_config
ADD config_files/sshd_config /etc/ssh/sshd_config
ADD config_files/supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
RUN echo 'root:updog'|chpasswd
ADD bash_scripts/run.sh /run.sh
RUN chmod 755 /*.sh
EXPOSE 22
CMD ["/run.sh"]
