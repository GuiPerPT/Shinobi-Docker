#!/bin/bash
if [ -e "INSTALL/installed.txt" ]; then
    /usr/bin/mysqld_safe --skip-grant-tables </dev/null &>/dev/null &
    cp /installation/conf.json /shinobi/ -f
    echo "Starting Shinobi"
    pm2 start /shinobi/camera.js
    pm2 start /shinobi/cron.js
    pm2 logs
fi
if [ ! -e "INSTALL/installed.txt" ]; then
    /usr/bin/mysqld_safe --skip-grant-tables </dev/null &>/dev/null &
    cp /installation/conf.json /shinobi/ -f
    chmod +x INSTALL/ubuntu.sh&&INSTALL/ubuntu.sh
    echo "Starting Shinobi"
    pm2 start /shinobi/camera.js
    pm2 start /shinobi/cron.js
    pm2 logs
fi
