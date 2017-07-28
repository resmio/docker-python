FROM ubuntu:14.04
MAINTAINER jann@resmio.com 

# Install Python and basic dependencies
RUN apt-get update -qq && apt-get install -y build-essential python python-dev libpq-dev ca-certificates git libxml2-dev libxslt-dev gettext binutils libproj-dev gdal-bin libffi-dev

# Use newer pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python - "pip==8.1.2"
RUN pip install virtualenv
