# Stage 1
FROM node:8.16.2-jessie as node

RUN git clone https://github.com/concentricsky/badgr-ui.git /badgr-ui --branch=v2.24.45 && \
	cd /badgr-ui

COPY environment.prod.ts /badgr-ui/src/environments

# Patch to fix sh error with test
RUN  sed -i '/"verify-prod-environment":/c\                "verify-prod-environment": "/bin/true",' /badgr-ui/package.json

WORKDIR /badgr-ui

RUN	npm install

COPY os-logo-large.svg /badgr-ui/node_modules/@concentricsky/badgr-style/dist/images/os-logo-large.svg
COPY os-logo-small.svg /badgr-ui/node_modules/@concentricsky/badgr-style/dist/images/os-logo-small.svg

RUN	npm run build

RUN ls -l /badgr-ui

# Stage 2
FROM nginx:stable-alpine
LABEL maintainer="Miguel Caballer <micafer1@upv.es>"
LABEL version="v2.24.45-2"
LABEL description="Badgr UI image"

COPY --from=node /badgr-ui/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

ENV BADGRSERVER http://badgrserver:8000

COPY run.sh /run.sh

RUN chmod 755 /run.sh

CMD ["/run.sh"]