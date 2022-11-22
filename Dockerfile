FROM ubuntu:jammy

RUN apt update -y
RUN apt upgrade -y

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt install -y swift swift-proxy swift-account swift-container swift-object \
		   supervisor rsyslog logrotate memcached \
		   python3-memcache pwgen python3-swiftclient

# add usefull tools for inspection & debugging 
RUN apt install -y less vim

RUN mkdir -p /var/log/supervisor
ADD files/supervisord.conf /etc/supervisor/conf.d/swift.conf

# disable imklog, otherwise rsyslogd will report an error on start
RUN sed 's/\(.*load="imklog".*\)/#\1/' -i /etc/rsyslog.conf

#
# Swift configuration
# - Partially fom http://docs.openstack.org/developer/swift/development_saio.html
#

# ADD files/rsyncd.conf /etc/rsyncd.conf
ADD files/swift.conf /etc/swift/swift.conf
ADD files/proxy-server.conf /etc/swift/proxy-server.conf
ADD files/account-server.conf /etc/swift/account-server.conf
ADD files/object-server.conf /etc/swift/object-server.conf
ADD files/container-server.conf /etc/swift/container-server.conf
ADD files/proxy-server.conf /etc/swift/proxy-server.conf
ADD files/startmain.sh /usr/local/bin/startmain.sh
RUN chmod 755 /usr/local/bin/*.sh

EXPOSE 8080

CMD /usr/local/bin/startmain.sh

