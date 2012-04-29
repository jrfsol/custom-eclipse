#!/bin/sh

if [ -z "$ECLIPSE_HOME" ] 
then
	ECLIPSE_HOME=/Applications/eclipse-jee-indigo-SR1-macosx-cocoa/eclipse/
	#exit 1;
fi

if [ -z "$1" ] 
then
	PROFILE=epp.package.java
else 
	PROFILE=$1
fi

if [ -z "$OS" ]
then
	OS="win32"
fi

if [ -z "$WS" ]
then
	WS="win32"
fi

if [ -z "$ARCH" ]
then
	ARCH="x86"
fi

if [ -z "$USE_MIRRORS" ]
then
	USE_MIRRORS="true"
fi

# output folder
BUILD_NAME="eclipse"
BUILD_DIR="`pwd`/$BUILD_NAME"

# output archive name
BUILD_ARCHIVE_NAME="$BUILD_NAME-$PROFILE-$OS-$WS-$ARCH"

# now load profile
if [ ! -f "profiles/$PROFILE.sh" ]
then
	exit 1
fi
source "profiles/$PROFILE.sh"

if [ -d "$BUILD_DIR" ]
then
	rm -rf $BUILD_DIR
fi

$ECLIPSE_HOME/eclipse \
	-nosplash \
	-application org.eclipse.equinox.p2.director \
	-repository $REPO_URLS \
	-installIU $FEATURES \
	-destination $BUILD_DIR \
	-roaming \
	-p2.os $OS -p2.ws $WS -p2.arch $ARCH \
	-profile $PROFILE \
	-tag $PROFILE \
	-purgeHistory \
	-profileProperties org.eclipse.update.install.features=true \
	-vmargs -Declipse.p2.mirrors=$USE_MIRRORS

if [ "$OS"="win32" ] || [ "$OS"="macosx" ]
then
	zip -r $BUILD_ARCHIVE_NAME.zip $BUILD_DIR
else
	tar zcvf $BUILD_ARCHIVE_NAME.tar.gz $BUILD_DIR
fi

