if [ -z "$REPO_URLS" ]
then
	REPO_URLS=$REPO_URLS,http://download.eclipse.org/technology/epp/packages/indigo/
else
	REPO_URLS=http://download.eclipse.org/technology/epp/packages/indigo/
fi

REPO_URLS=$REPO_URLS,http://download.eclipse.org/releases/indigo
REPO_URLS=$REPO_URLS,http://download.eclipse.org/eclipse/updates/3.7

FEATURES=epp.package.java
