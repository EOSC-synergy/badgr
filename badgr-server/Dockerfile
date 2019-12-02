FROM ubuntu:18.04
LABEL maintainer="Miguel Caballer <micafer1@upv.es>"
LABEL version="v2.24.1-1"
LABEL description="Badgr server image"
EXPOSE 8800

RUN apt-get update && apt-get install --no-install-recommends -y \
    apache2 \
    libapache2-mod-wsgi \
    git \
    git-core  \
    gcc  \
    python-pip \
    python-dev \
    libjpeg-turbo8 \
    libjpeg-turbo8-dev \
    swig \
    libxslt-dev \
    automake \
    autoconf \
    libtool \
    libffi-dev \
    libssl-dev \
    libmysqlclient-dev \
    python-cairo \
    python-setuptools && \
    mkdir badgr && cd badgr && \
    git clone https://github.com/concentricsky/badgr-server.git --branch=v2.24.1 code  && \
    pip install wheel   && \
    pip install -r /badgr/code/requirements.txt && \
    pip install /badgr/code && \
    apt-get purge -y gcc git python-dev python-pip libmysqld-dev libssl-dev libxslt-dev libjpeg-turbo8-dev automake autoconf git-core git && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && rm -rf ~/.cache/

# Enable SSL
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load
# Copy dummy certificates
COPY server.crt /etc/ssl/certs/server.crt
COPY server.key /etc/ssl/certs/server.key

# Change ports
RUN sed -i -e 's/Listen 80/Listen 8000/g' /etc/apache2/ports.conf
RUN sed -i -e 's/Listen 443/Listen 8443/g' /etc/apache2/ports.conf

# Copy badgr app configuration
COPY badgr.conf /etc/apache2/conf-enabled/badgr.conf
# Create log dir
RUN mkdir /badgr/code/logs

# Copy app local files
COPY settings_local.py /badgr/code/apps/mainsite/settings_local.py
COPY wsgi.py /badgr/code/wsgi.py
COPY local.sqlite3 /badgr/code/local.sqlite3

# Set correct perms
RUN chown www-data -R /badgr/code

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]