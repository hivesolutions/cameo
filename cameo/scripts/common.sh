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

# This script sets up a consistent environment for the other scripts in this directory.

# Set up paths for a specific clone of the SDK source
if [ -z "$CAMEO_SDK_SCRIPT" ]; then
  # ---------------------------------------------------------------------------
  # Versioning for the SDK
  #
  CAMEO_SDK_VERSION_MAJOR=0
  CAMEO_SDK_VERSION_MINOR=1
  test -n "$CAMEO_SDK_VERSION_BUILD" || CAMEO_SDK_VERSION_BUILD=$(date '+%Y%m%d')
  CAMEO_SDK_VERSION=${CAMEO_SDK_VERSION_MAJOR}.${CAMEO_SDK_VERSION_MINOR}
  CAMEO_SDK_VERSION_FULL=${CAMEO_SDK_VERSION}.${CAMEO_SDK_VERSION_BUILD}

  # ---------------------------------------------------------------------------
  # Set up paths
  #

  # The directory containing this script
  # We need to go there and use pwd so these are all absolute paths
  pushd $(dirname $0) >/dev/null
  CAMEO_SDK_SCRIPT=$(pwd)
  popd >/dev/null

  # The root directory where the Facebook SDK for iOS is cloned
  CAMEO_SDK_ROOT=$(dirname $CAMEO_SDK_SCRIPT)

  # Path to source files for Cameo
  CAMEO_SDK_SRC=$CAMEO_SDK_ROOT/..

  # Path to sample files for Cameo
  CAMEO_SDK_SAMPLES=$CAMEO_SDK_ROOT/samples

  # The directory where the target is built
  CAMEO_SDK_BUILD=$CAMEO_SDK_ROOT/build
  CAMEO_SDK_BUILD_LOG=$CAMEO_SDK_BUILD/build.log

  # The name of the Facebook SDK for iOS
  CAMEO_SDK_BINARY_NAME=CameoSDK

  # The name of the Facebook SDK for iOS framework
  CAMEO_SDK_FRAMEWORK_NAME=${CAMEO_SDK_BINARY_NAME}.framework

  # The path to the built Facebook SDK for iOS .framework
  CAMEO_SDK_FRAMEWORK=$CAMEO_SDK_BUILD/$CAMEO_SDK_FRAMEWORK_NAME

  # The name of the docset
  CAMEO_SDK_DOCSET_NAME=pt.hive.Cameo-0_1-for-iOS.docset

  # The path to the framework docs
  CAMEO_SDK_FRAMEWORK_DOCS=$CAMEO_SDK_BUILD/$CAMEO_SDK_DOCSET_NAME

fi

# Set up one-time variables
if [ -z $CAMEO_SDK_ENV ]; then
  CAMEO_SDK_ENV=env1
  CAMEO_SDK_BUILD_DEPTH=0

  # Explains where the log is if this is the outermost build or if
  # we hit a fatal error.
  function show_summary() {
    test -r $CAMEO_SDK_BUILD_LOG && echo "Build log is at $CAMEO_SDK_BUILD_LOG"
  }

  # Determines whether this is out the outermost build.
  function is_outermost_build() {
      test 1 -eq $CAMEO_SDK_BUILD_DEPTH
  }

  # Calls show_summary if this is the outermost build.
  # Do not call outside common.sh.
  function pop_common() {
    CAMEO_SDK_BUILD_DEPTH=$(($CAMEO_SDK_BUILD_DEPTH - 1))
    test 0 -eq $CAMEO_SDK_BUILD_DEPTH && show_summary
  }

  # Deletes any previous build log if this is the outermost build.
  # Do not call outside common.sh.
  function push_common() {
    test 0 -eq $CAMEO_SDK_BUILD_DEPTH && \rm -f $CAMEO_SDK_BUILD_LOG
    CAMEO_SDK_BUILD_DEPTH=$(($CAMEO_SDK_BUILD_DEPTH + 1))
  }

  # Echoes a progress message to stderr
  function progress_message() {
      echo "$@" >&2
  }

  # Any script that includes common.sh must call this once if it finishes
  # successfully.
  function common_success() { 
      pop_common
      return 0
  }

  # Call this when there is an error.  This does not return.
  function die() {
    echo ""
    echo "FATAL: $*" >&2
    show_summary
    exit 1
  }

  test -n "$XCODEBUILD"   || XCODEBUILD=$(which xcodebuild)
  test -n "$LIPO"         || LIPO=$(which lipo)
  test -n "$PACKAGEMAKER" || PACKAGEMAKER=$(which PackageMaker)

  # < XCode 4.3.1
  if [ ! -x "$XCODEBUILD" ]; then
    # XCode from app store
    XCODEBUILD=/Applications/XCode.app/Contents/Developer/usr/bin/xcodebuild
  fi

  if [ ! -x "$PACKAGEMAKER" ]; then
    PACKAGEMAKER=/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker
  fi

  if [ ! -x "$PACKAGEMAKER" ]; then
    PACKAGEMAKER=/Applications/PackageMaker.app/Contents/MacOS/PackageMaker
  fi
fi

# Increment depth every time we . this file.  At the end of any script
# that .'s this file, there should be a call to common_finish to decrement.
push_common
