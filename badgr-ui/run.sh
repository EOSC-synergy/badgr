#!/bin/sh
# Script to enable to use ENV variable to set the URL of the badgr server
sed -i 's#http:\/\/badgrserverhost:8000#'"$BADGRSERVER"'#g' /usr/share/nginx/html/main.*.js

nginx -g "daemon off;"