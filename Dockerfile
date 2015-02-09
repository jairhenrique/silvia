FROM ubuntu:14.04

# add newrelic repo
RUN echo "deb http://apt.newrelic.com/debian/ newrelic non-free" >> /etc/apt/sources.list.d/newrelic.list
RUN bash -c '{ exec 3<>/dev/tcp/download.newrelic.com/80; echo -en "GET /548C16BF.gpg HTTP/1.1\r\nHost:download.newrelic.com\r\nConnection: close\r\n\r\n" >&3; while read a;do echo $a; done <&3; exec 3>&1; }' | awk '/BEGIN/,/END/{print}' | apt-key add -

# install os dependencies
RUN apt-get update
RUN apt-get install -y build-essential curl software-properties-common libmysqlclient-dev python-setuptools python2.7 python2.7-dev  newrelic-sysmond nginx supervisor
RUN add-apt-repository -y ppa:nginx/stable
RUN easy_install pip
