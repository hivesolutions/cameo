#!/bin/sh

# Hive Cameo Framework
# Copyright (C) 2008-2015 Hive Solutions Lda.
#
# This file is part of Hive Cameo Framework.
#
# Hive Cameo Framework is free software: you can redistribute it and/or modify
# it under the terms of the Apache License as published by the Apache
# Foundation, either version 2.0 of the License, or (at your option) any
# later version.
#
# Hive Cameo Framework is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# Apache License for more details.
#
# You should have received a copy of the Apache License along with
# Hive Cameo Framework. If not, see <http://www.apache.org/licenses/>.

# __author__    = João Magalhães <joamag@hive.pt>
# __version__   = 1.0.0
# __revision__  = $LastChangedRevision$
# __date__      = $LastChangedDate$
# __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
# __license__   = Apache License, Version 2.0

. ${CAMEO_SDK_SCRIPT:-$(dirname $0)}/common.sh

# process options, valid arguments -c [Debug|Release] -n
BUILDCONFIGURATION=Release
while getopts ":nc:" OPTNAME
do
  case "$OPTNAME" in
    "c")
      BUILDCONFIGURATION=$OPTARG
      ;;
    "n")
      NOEXTRAS=1
      ;;
    "?")
      echo "$0 -c [Debug|Release] -n"
      echo "       -c sets configuration"
      echo "       -n no test run"
      die
      ;;
    ":")
      echo "Missing argument value for option $OPTARG"
      die
      ;;
    *)
      echo "Unknown error while processing options"
      die
      ;;
  esac
done

test -x "$XCODEBUILD" || die 'Could not find xcodebuild in $PATH'
test -x "$LIPO" || die 'Could not find lipo in $PATH'

CAMEO_SDK_UNIVERSAL_BINARY=$CAMEO_SDK_BUILD/${BUILDCONFIGURATION}-universal/$CAMEO_SDK_BINARY_NAME

progress_message Building Framework.

# runs the compilation operation by calling the
# xcode build command
test -d $CAMEO_SDK_BUILD \
  || mkdir -p $CAMEO_SDK_BUILD \
  || die "Could not create directory $CAMEO_SDK_BUILD"

cd $CAMEO_SDK_SRC
function xcode_build_target() {
  echo "Compiling for platform: ${1}."
  $XCODEBUILD \
    -target "cameo" \
    -sdk $1 \
    -configuration "${2}" \
    SYMROOT=$CAMEO_SDK_BUILD \
    CURRENT_PROJECT_VERSION=$CAMEO_SDK_VERSION_FULL \
    clean build \
    || die "XCode build failed for platform: ${1}."
}

xcode_build_target "iphonesimulator" "$BUILDCONFIGURATION"
xcode_build_target "iphoneos" "$BUILDCONFIGURATION"

# merge slib files for different platforms into universal binary
progress_message "Building $CAMEO_SDK_BINARY_NAME library using lipo."

mkdir -p $(dirname $CAMEO_SDK_UNIVERSAL_BINARY)

$LIPO \
  -create \
    $CAMEO_SDK_BUILD/${BUILDCONFIGURATION}-iphonesimulator/libcameo.a \
    $CAMEO_SDK_BUILD/${BUILDCONFIGURATION}-iphoneos/libcameo.a \
  -output $CAMEO_SDK_UNIVERSAL_BINARY \
  || die "lipo failed - could not create universal static library"

# builds .framework out of binaries
progress_message "Building $CAMEO_SDK_FRAMEWORK_NAME."

\rm -rf $CAMEO_SDK_FRAMEWORK
mkdir $CAMEO_SDK_FRAMEWORK \
  || die "Could not create directory $CAMEO_SDK_FRAMEWORK"
mkdir $CAMEO_SDK_FRAMEWORK/Versions
mkdir $CAMEO_SDK_FRAMEWORK/Versions/A
mkdir $CAMEO_SDK_FRAMEWORK/Versions/A/Headers
mkdir $CAMEO_SDK_FRAMEWORK/Versions/A/DeprecatedHeaders
mkdir $CAMEO_SDK_FRAMEWORK/Versions/A/Resources

\cp \
  $CAMEO_SDK_BUILD/${BUILDCONFIGURATION}-iphoneos/cameo/*.h \
  $CAMEO_SDK_FRAMEWORK/Versions/A/Headers \
  || die "Error building framework while copying SDK headers"
\cp \
  $CAMEO_SDK_BUILD/${BUILDCONFIGURATION}-iphoneos/cameo/*.h \
  $CAMEO_SDK_FRAMEWORK/Versions/A/DeprecatedHeaders \
  || die "Error building framework while copying SDK headers to deprecated folder"
for HEADER in
do
  \cp \
    $CAMEO_SDK_SRC/$HEADER \
    $CAMEO_SDK_FRAMEWORK/Versions/A/DeprecatedHeaders \
    || die "Error building framework while copying deprecated SDK headers"
done
\cp \
  $CAMEO_SDK_SRC/src/static/* \
  $CAMEO_SDK_FRAMEWORK/Versions/A/Resources \
  || die "Error building framework while copying Resources"
\cp -r \
  $CAMEO_SDK_SRC/src/bundles/*.bundle \
  $CAMEO_SDK_FRAMEWORK/Versions/A/Resources \
  || die "Error building framework while copying bundle to Resources"
\cp \
  $CAMEO_SDK_UNIVERSAL_BINARY \
  $CAMEO_SDK_FRAMEWORK/Versions/A/Cameo \
  || die "Error building framework while copying Cameria Framework"

# must change the current directory for the
# creation of the symbolic link
cd $CAMEO_SDK_FRAMEWORK
ln -s ./Versions/A/Headers ./Headers
ln -s ./Versions/A/Resources ./Resources
ln -s ./Versions/A/Cameo ./Cameo
cd $CAMEO_SDK_FRAMEWORK/Versions
ln -s ./A ./Current

# runs the various unit tests, taking into account
# the value of th no extras flag
if [ ${NOEXTRAS:-0} -eq 1 ]; then
  progress_message "Skipping unit tests."
else
  progress_message "Running unit tests."
  cd $CAMEO_SDK_SRC
  $XCODEBUILD -sdk iphonesimulator -configuration Debug -scheme cameo-tests build
fi

progress_message "Framework version info:" `perl -pe "s/.*@//" < $CAMEO_SDK_SRC/cameo/classes/HMVersion.h`
common_success
