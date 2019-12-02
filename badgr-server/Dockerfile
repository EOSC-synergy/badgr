FROM ubuntu:18.04
LABEL maintainer="Miguel Caballer <micafer1@upv.es>"
LABEL version="v2.24.1-1"
LABEL description="Badgr server image"
EXPOSE 8800

RUN apt-get update && apt-get install --no-install-recommends -y \
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
    apt-get purge -y gcc git python-dev python-pip libmysqld-dev libssl-dev libxslt-dev libjpeg-turbo8-dev automake autoconf git-core git && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && rm -rf ~/.cache/

WORKDIR /badgr/code

COPY settings_local.py apps/mainsite/settings_local.py

RUN ./manage.py migrate
RUN ./manage.py dist

COPY local.sqlite3 /badgr/code/local.sqlite3

CMD ./manage.py runserver 0.0.0.0:8000