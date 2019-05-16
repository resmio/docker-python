FROM ubuntu:16.04
MAINTAINER services@resmio.com

# Install Python and basic dependencies
RUN apt-get update -y -qq && apt-get install software-properties-common -y
RUN add-apt-repository ppa:jonathonf/python-3.6 -y && apt-get update -qq && apt-get upgrade -y && apt-get install -y build-essential python3.6 python3.6-dev libpq-dev ca-certificates git libxml2-dev libxslt-dev gettext binutils libproj-dev gdal-bin libffi-dev

# Use newer pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.6 - "pip==19.1"

# We install an older version of the requirements to
# an temporary virtualenv so packages can be cached globally.
# When requirements.txt changes, pip installing it again will be much faster
RUN pip install virtualenv
COPY requirements.txt /tmp/requirements.txt
RUN virtualenv --python=python3.6 /tmp/tmpenv && tmp/tmpenv/bin/pip install -r /tmp/requirements.txt --src $HOME && rm -r /tmp/tmpenv
RUN ln /usr/bin/python3.6 /usr/bin/python

# This is for debugging, modules in /src (the project root) will be imported first
ENV PYTHONPATH $PYTHONPATH:/src

VOLUME ["/src"]
WORKDIR /src
