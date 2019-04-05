file="/shinobi/INSTALL/start.sh"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo $(pwd)
if [ -f "/shinobi/.git" ]
then
cd /shinobi && git fetch && git checkout -t origin/master && chmod +x INSTALL/start.sh && chmod +x INSTALL/ubuntu.sh && INSTALL/ubuntu.sh && cp /installation/conf.json /shinobi
else
cd /shinobi && git init && git remote add origin https://gitlab.com/Shinobi-Systems/Shinobi.git && git fetch && git checkout -t origin/master && chmod +x INSTALL/start.sh && chmod +x INSTALL/ubuntu.sh && INSTALL/ubuntu.sh && cp /installation/conf.json /shinobi
fi
fi

