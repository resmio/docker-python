FROM stackbrew/ubuntu:14.04
MAINTAINER jann@resmio.com 

# Install Python Setuptools and basic dependencies
RUN apt-get update -qq && apt-get install -y build-essential python python-pip python-dev libpq-dev ca-certificates git libxml2-dev libxslt-dev gettext binutils libproj-dev gdal-bin

