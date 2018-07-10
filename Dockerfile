FROM ubuntu:16.04
MAINTAINER jann@resmio.com 

# Install Python and basic dependencies
RUN apt-get update -qq && apt-get install -y build-essential python python-dev libpq-dev ca-certificates git libxml2-dev libxslt-dev gettext binutils libproj-dev gdal-bin libffi-dev

# Use newer pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python - "pip==9.0.2"

# We install a more stable, older version of the requirements to
# an temporary virtualenv so packages can be cached globally.
# When requirements.txt changes, pip installing it again will be much faster
RUN pip install virtualenv
COPY requirements.txt /tmp/requirements.txt
RUN virtualenv /tmp/tmpenv && /tmp/tmpenv/bin/pip install -r /tmp/oldrequirements.txt --src $HOME && rm -r /tmp/tmpenv

# we need that for the web container to epxpose that port
# unfortanly this also effects other containers using that image
EXPOSE 8000

# This is for debugging, modules in /src (the project root) will be imported first
ENV PYTHONPATH $PYTHONPATH:/src

VOLUME ["/src"]
WORKDIR /src
