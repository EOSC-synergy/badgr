#!/bin/sh
# Script to enable to use ENV variable to set the URL of the badgr server and the base dir
sed -i 's#http:\/\/badgrserverhost:8000#'"$BADGRSERVER"'#g' /usr/share/nginx/html/main.*.js

# Set the basedir
sed -i 's#<base href=\/ >#<base href='$BASE_DIR' >#g' /usr/share/nginx/html/index.html

nginx -g "daemon off;"