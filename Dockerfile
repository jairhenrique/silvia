FROM ubuntu:14.04

MAINTAINER Jair Henrique <jair.henrique@gmal.com>

# add newrelic repo
RUN echo "deb http://apt.newrelic.com/debian/ newrelic non-free" >> /etc/apt/sources.list.d/newrelic.list
RUN bash -c '{ exec 3<>/dev/tcp/download.newrelic.com/80; echo -en "GET /548C16BF.gpg HTTP/1.1\r\nHost:download.newrelic.com\r\nConnection: close\r\n\r\n" >&3; while read a;do echo $a; done <&3; exec 3>&1; }' | awk '/BEGIN/,/END/{print}' | apt-key add -
RUN echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
RUN bash -c '{ exec 3<>/dev/tcp/nginx.org/80; echo -en "GET /keys/nginx_signing.key HTTP/1.1\r\nHost:nginx.org\r\nConnection: close\r\n\r\n" >&3; while read a;do echo $a; done <&3; exec 3>&1; }' | awk '/BEGIN/,/END/{print}' | apt-key add -

# install os dependencies
RUN apt-get update
RUN apt-get install -y build-essential curl software-properties-common libmysqlclient-dev python-setuptools python2.7 python2.7-dev newrelic-sysmond nginx supervisor nginx-nr-agent
RUN easy_install pip
