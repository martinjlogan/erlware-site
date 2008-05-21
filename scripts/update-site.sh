#!/bin/sh

# be paranoid
set -e

export PATH=$PATH:/usr/bin:/usr/local/bin:/bin

# Define common places
if [ "$1" == "--test" ]; then
    SITE_HOME=/tmp/erlware_site_test
    WWW_HOME=/tmp/erlware_site_test/www
else
    SITE_HOME=/usr/local/scripts/site
    WWW_HOME=/usr/local/www
fi

# Update the local repository
cd $SITE_HOME/erlware-site

logger -t erlware-site "pulling from canonical"

git pull

# Generate the local copy
logger -t erlware-site "generating site"
webgen run

# Move portius templates to .src files to:
#  * Avoid overwriting actual html files when installing the site
#  * Make them available to portius
logger -t erlware-site "moving templates to .src"

for TEMPLATE in \
    output/documentation/index.html \
    output/documentation/releases.html; do
    mv $TEMPLATE $TEMPLATE.src
done

# Publish the site
logger -t erlware-site "rsyncing"
rsync -vaz $SITE_HOME/erlware-site/output/ $WWW_HOME/erlware
logger -t erlware-site "erlware.org updated"
