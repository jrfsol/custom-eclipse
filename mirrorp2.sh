#!/bin/bash
#
# script to mirror an existing p2 repository for local / offline use
#
# example:
# ./mirrorp2.sh http://pydev.org/updates/ pydev
#

# source p2 repo, eg http://pydev.org/updates/
SOURCE=$1

# path of the local site, eg pydev
LOCAL_SITE=$2

# location of eclipse
ECLIPSE=/Applications/eclipse-jee-indigo-SR1-macosx-cocoa/eclipse
export ECLIPSE LOCAL_SITE SOURCE SITE_NAME

echo Mirroring metadata for $SOURCE
java -jar $ECLIPSE/plugins/org.eclipse.equinox.launcher_*.jar \
     -application org.eclipse.equinox.p2.metadata.repository.mirrorApplication \
     -source $SOURCE \
     -destination $LOCAL_SITE \
     -verbose -ignoreErrors


echo Mirroring artifacts for $SOURCE 
java -jar $ECLIPSE/plugins/org.eclipse.equinox.launcher_*.jar \
     -application org.eclipse.equinox.p2.artifact.repository.mirrorApplication \
     -source $SOURCE \
     -destination $LOCAL_SITE \
     -verbose -ignoreErrors
