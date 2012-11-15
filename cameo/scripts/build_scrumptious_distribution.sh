#!/bin/sh

# Hive Cameo Framework
# Copyright (C) 2008-2012 Hive Solutions Lda.
#
# This file is part of Hive Cameo Framework.
#
# Hive Cameo Framework is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Hive Cameo Framework is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Hive Cameo Framework. If not, see <http://www.gnu.org/licenses/>.

# __author__    = João Magalhães <joamag@hive.pt>
# __version__   = 1.0.0
# __revision__  = $LastChangedRevision$
# __date__      = $LastChangedDate$
# __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
# __license__   = GNU General Public License (GPL), Version 3

# This script builds the Scrumptious sample app for internal distribution.
# It requires a provisioning profile UUID, build number, and file name for
# the final package.

. ${CAMEO_SDK_SCRIPT:-$(dirname $0)}/common.sh

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 BUILD_NUMBER PRODUCT_NAME PROFILE_UUID CODE_SIGN_IDENTITY"
    echo "  BUILD_NUMBER         build number to place in bundle"
    echo "  PRODUCT_NAME         name of the final .ipa package (e.g., Scrumptious.ipa)"
    echo "  PROFILE_UUID         UUID of the provisioning profile"
    echo "  CODE_SIGN_IDENTITY   name of the code sign identity"
    die 'Invalid arguments'
fi

BUILD_NUMBER="$1"
FINAL_PRODUCT_NAME="$2"
PROFILE_UUID="$3"
CODE_SIGN_IDENTITY="$4"

test -x "$XCODEBUILD" || die 'Could not find xcodebuild in $PATH'

# -----------------------------------------------------------------------------
progress_message 'Building Scrumptious (Distribution).'

# -----------------------------------------------------------------------------
# Call out to build .framework
#
if is_outermost_build; then
  . $CAMEO_SDK_SCRIPT/build_framework.sh
fi

# -----------------------------------------------------------------------------
# Build Scrumptious
#
PRODUCT_NAME="Scrumptious"
CONFIGURATION="Release"
SDK="iphoneos"
APP_NAME="$PRODUCT_NAME".app

OUTPUT_DIR=`mktemp -d -t ${PRODUCT_NAME}-inhouse`
RESULTS_DIR="$OUTPUT_DIR"/"$CONFIGURATION"-"$SDK"

cd $CAMEO_SDK_SAMPLES/Scrumptious

$XCODEBUILD \
  -alltargets \
  -sdk "$SDK" \
  -configuration "$CONFIGURATION" \
  -arch "armv7 armv6" \
  SYMROOT="$OUTPUT_DIR" \
  OBJROOT="$OUTPUT_DIR" \
  CURRENT_PROJECT_VERSION="$CAMEO_SDK_VERSION_FULL" \
  CODE_SIGN_IDENTITY="$CODE_SIGN_IDENTITY" \
  PROVISIONING_PROFILE="$PROFILE_UUID" \
  FB_BUNDLE_VERSION="$BUILD_NUMBER" \
  clean build \
  || die "XCode build failed for Scrumptious (Distribution)."

# -----------------------------------------------------------------------------
# Build .ipa package
#
progress_message Building Package

PACKAGE_DIR=`mktemp -d -t ${PRODUCT_NAME}-inhouse-pkg`

pushd "$PACKAGE_DIR" >/dev/null
PAYLOAD_DIR="Payload"
mkdir "$PAYLOAD_DIR"
cp -a "$RESULTS_DIR"/"$APP_NAME" "$PAYLOAD_DIR"
rm -f "$FINAL_PRODUCT_NAME"
zip -y -r "$FINAL_PRODUCT_NAME" "$PAYLOAD_DIR" 
progress_message ...Package at: "$PACKAGE_DIR"/"$FINAL_PRODUCT_NAME"


# -----------------------------------------------------------------------------
# Validate .ipa package
#
progress_message Validating Package

# Apple's Validation tool exits with error code 0 even on error, so we have to search the output.
VALIDATION_TOOL="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/Validation"
VALIDATION_RESULT=`"$VALIDATION_TOOL" -verbose -errors "$FINAL_PRODUCT_NAME"`
if [[ "$VALIDATION_RESULT" == *error:* ]]; then
    echo "Validation failed: $VALIDATION_RESULT"
    exit 1
fi

popd >/dev/null

# -----------------------------------------------------------------------------
# Archive the build and .dSYM symbols
progress_message Archiving build and symbols

BUILD_ARCHIVE_DIR=~/iossdkarchive/"$PRODUCT_NAME"/"$BUILD_NUMBER"
mkdir -p "$BUILD_ARCHIVE_DIR"

pushd "$RESULTS_DIR" >/dev/null

ARCHIVE_PATH="$BUILD_ARCHIVE_DIR"/Archive-"$BUILD_NUMBER".zip
zip -y -r "$ARCHIVE_PATH" "$APP_NAME" "$APP_NAME".dSYM 
progress_message ...Archive at: "$ARCHIVE_PATH"

popd >/dev/null

# -----------------------------------------------------------------------------
# Done
#
common_success
