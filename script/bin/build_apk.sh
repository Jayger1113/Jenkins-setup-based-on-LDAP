#!/bin/bash
# This script tend to build gradle based apk

#  tag to push
#  ++++++++++++
TAG_HASH=$(git rev-list --tags --max-count=1)
TAG_LATEST=$(git describe --tags ${TAG_HASH})

PROJECT_NAME=$(echo $TAG_LATEST | cut -d "_" -f 1)
VERSION_FULL=$(echo $TAG_LATEST | cut -d "_" -f 2)

VERSION_MAJOR=$(echo $VERSION_FULL | cut -d "." -f 1)
VERSION_MINOR=$(echo $VERSION_FULL | cut -d "." -f 2)
VERSION_PATCH=$(echo $VERSION_FULL | cut -d "." -f 3)
VERSION_LAST_BUILD_SUCCESS=$(echo $VERSION_FULL | cut -d "." -f 4)
COUNT=1
VERSION_BUILD_SUCCESS=$((VERSION_LAST_BUILD_SUCCESS + COUNT))

VERSION_TAG_PUSH="${PROJECT_NAME}_${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}.${VERSION_BUILD_SUCCESS}"

#echo $PROJECT_NAME
#echo $VERSION_FULL
#echo $VERSION_MAJOR
#echo $VERSION_MINOR
#echo $VERSION_PATCH
#echo $VERSION_BUILD_SUCCESS

# inject VERSION_TAG_PUSH to tag.property
echo VERSION_TAG_PUSH=${VERSION_TAG_PUSH} > tag.property
# -------------

cp -f $JENKINS_SCRIPT_HOME/gradle/settings.gradle settings.gradle


if [ $proguard = On ]
then
    cat $JENKINS_SCRIPT_HOME/gradle/proguard/build.gradle >> build.gradle
else
    cat $JENKINS_SCRIPT_HOME/gradle/noproguard/build.gradle >> build.gradle
fi

mkdir debug_key
cp -f $JENKINS_SCRIPT_HOME/debug_key/debug.keystore debug_key/debug.keystore

ls
#cat build.gradle
