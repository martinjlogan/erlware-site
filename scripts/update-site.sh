#!/bin/sh


# be paranoid
set -e

export PATH=$PATH:/usr/bin:/usr/local/bin:/bin
export SITE_HOME=/usr/local/scripts/site
cd $SITE_HOME/erlware-site
logger -t erlware-site "pulling from canonical"
git pull
logger -t erlware-site "generating site"
webgen run

# Support for portius
logger -t erlware-site "moving templates to .src"

if [ -f "output/erlware/repository_applications.html" ]; then
    mv output/erlware/repository_applications.html \
	output/erlware/repository_applications.html.src
fi
if [ -f "output/erlware/repository_releases.html" ]; then
    mv output/erlware/repository_releases.html \
	output/erlware/repository_releases.html.src
fi

# Publish the site
logger -t erlware-site "rsyncing"
rsync -vaz $SITE_HOME/erlware-site/output/ /usr/local/www/erlware/
logger -t erlware-site "erlware.org updated"
