FROM ubuntu:22.04
MAINTAINER services@resmio.com

# Install Python and basic dependencies
RUN apt-get update -y -qq && apt-get install software-properties-common -y
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -y \
    build-essential python3-distutils python3.10 python3.10-dev \
    libpq-dev ca-certificates git libxml2-dev libxslt-dev \
    gettext binutils libproj-dev gdal-bin libffi-dev

# Use newer pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.10 - "pip==23.2"

# We install an older version of the requirements to
# an temporary virtualenv so packages can be cached globally.
# When requirements.txt changes, pip installing it again will be much faster
# RUN pip install virtualenv
COPY requirements.txt /tmp/requirements.txt
# RUN python3 -m venv /tmp/tmpenv && /tmp/tmpenv/bin/pip install -r /tmp/requirements.txt --src $HOME && rm -r /tmp/tmpenv
RUN pip3 install -r /tmp/requirements.txt
RUN ln /usr/bin/python3.10 /usr/bin/python

# This is for debugging, modules in /src (the project root) will be imported first
ENV PYTHONPATH $PYTHONPATH:/src

VOLUME ["/src"]
WORKDIR /src
