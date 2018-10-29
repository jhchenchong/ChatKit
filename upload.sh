#!/bin/bash

VersionString=`grep -E 's.version.*=' ChatKit.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' ChatKit.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" ChatKit.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
#pod repo push PrivatePods ChatKit.podspec --verbose --allow-warnings --use-libraries
pod trunk push ChatKit.podspec --verbose --allow-warnings --use-libraries
