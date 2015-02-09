FROM ubuntu:14.04

# install os dependencies
RUN apt-get update
RUN apt-get install -y build-essential curl wget software-properties-common libmysqlclient-dev python-setuptools python2.7 python2.7-dev
RUN add-apt-repository -y ppa:nginx/stable
RUN easy_install pip

# add newrelic repo
RUN echo "deb http://apt.newrelic.com/debian/ newrelic non-free" >> /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -

# install more dependencies
RUN apt-get update
RUN apt-get install -y newrelic-sysmond nginx supervisor
