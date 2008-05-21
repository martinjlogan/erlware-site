#!/bin/sh
#
# Tests update_site.sh script

if [ -z "$1" ]; then
    PROGRAM=`basename $0`
    echo
    echo "Usage: $PROGRAM <site-repo-dir>"
    echo
    exit 1
fi

REPO_HOME="$1"
SITE_HOME="/tmp/erlware_site_test"
WWW_HOME="/tmp/erlware_site_test/www"

# Create directories
rm -rf /tmp/erlware_site_test
mkdir -p $SITE_HOME
mkdir -p $WWW_HOME/erlware

# Clone repository

cd $SITE_HOME
git clone $REPO_HOME

cd -

# Run update-site
$REPO_HOME/scripts/update-site.sh --test

cd -