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

# run the set up paths for a specific clone of
# the sdk source
if [ -z "$CAMEO_SDK_SCRIPT" ]; then
  # creates the various variables related with versioning
  # of the software for the current project
  CAMEO_SDK_VERSION_MAJOR=0
  CAMEO_SDK_VERSION_MINOR=1
  test -n "$CAMEO_SDK_VERSION_BUILD" || CAMEO_SDK_VERSION_BUILD=$(date '+%Y%m%d')
  CAMEO_SDK_VERSION=${CAMEO_SDK_VERSION_MAJOR}.${CAMEO_SDK_VERSION_MINOR}
  CAMEO_SDK_VERSION_FULL=${CAMEO_SDK_VERSION}.${CAMEO_SDK_VERSION_BUILD}

  # the directory containing this script, need to go
  # there and use pwd so these are all absolute paths
  pushd $(dirname $0) >/dev/null
  CAMEO_SDK_SCRIPT=$(pwd)
  popd >/dev/null

  # creates the various path related variables for the
  # project, note that most of then are relative based
  CAMEO_SDK_ROOT=$(dirname $CAMEO_SDK_SCRIPT)
  CAMEO_SDK_SRC=$CAMEO_SDK_ROOT/..
  CAMEO_SDK_SAMPLES=$CAMEO_SDK_SRC/samples
  CAMEO_SDK_BUILD=$CAMEO_SDK_ROOT/build
  CAMEO_SDK_BUILD_LOG=$CAMEO_SDK_BUILD/build.log

  # creates and sets the various variables related with
  # naming for the current project
  CAMEO_SDK_BINARY_NAME=Cameo
  CAMEO_SDK_FRAMEWORK_NAME=${CAMEO_SDK_BINARY_NAME}.framework
  CAMEO_SDK_FRAMEWORK=$CAMEO_SDK_BUILD/$CAMEO_SDK_FRAMEWORK_NAME

  # creates the variables associated with documentation
  # for the project
  CAMEO_SDK_DOCSET_NAME=pt.hive.Cameo-0_1-for-iOS.docset
  CAMEO_SDK_FRAMEWORK_DOCS=$CAMEO_SDK_BUILD/$CAMEO_SDK_DOCSET_NAME

fi

# runs the set up one-time variables
if [ -z $CAMEO_SDK_ENV ]; then
  CAMEO_SDK_ENV=env1
  CAMEO_SDK_BUILD_DEPTH=0

  # explains where the log is if this is the outermost build or if
  # we hit a fatal error
  function show_summary() {
    test -r $CAMEO_SDK_BUILD_LOG && echo "Build log is at $CAMEO_SDK_BUILD_LOG"
  }

  # determines whether this is out the outermost build.
  function is_outermost_build() {
      test 1 -eq $CAMEO_SDK_BUILD_DEPTH
  }

  # calls show_summary if this is the outermost build, do
  # not call outside common.sh
  function pop_common() {
    CAMEO_SDK_BUILD_DEPTH=$(($CAMEO_SDK_BUILD_DEPTH - 1))
    test 0 -eq $CAMEO_SDK_BUILD_DEPTH && show_summary
  }

  # deletes any previous build log if this is the outermost build, do
  # not call outside common.sh
  function push_common() {
    test 0 -eq $CAMEO_SDK_BUILD_DEPTH && \rm -f $CAMEO_SDK_BUILD_LOG
    CAMEO_SDK_BUILD_DEPTH=$(($CAMEO_SDK_BUILD_DEPTH + 1))
  }

  # echoes a progress message to stderr
  function progress_message() {
      echo "$@" >&2
  }

  # any script that includes common.sh must call this once if it finishes
  # successfully
  function common_success() { 
      pop_common
      return 0
  }

  # call this when there is an error, this does not return
  function die() {
    echo ""
    echo "FATAL: $*" >&2
    show_summary
    exit 1
  }

  test -n "$XCODEBUILD"   || XCODEBUILD=$(which xcodebuild)
  test -n "$LIPO"         || LIPO=$(which lipo)
  test -n "$PACKAGEMAKER" || PACKAGEMAKER=$(which PackageMaker)

  if [ ! -x "$XCODEBUILD" ]; then
    XCODEBUILD=/Applications/XCode.app/Contents/Developer/usr/bin/xcodebuild
  fi

  if [ ! -x "$PACKAGEMAKER" ]; then
    PACKAGEMAKER=/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker
  fi

  if [ ! -x "$PACKAGEMAKER" ]; then
    PACKAGEMAKER=/Applications/PackageMaker.app/Contents/MacOS/PackageMaker
  fi
fi

# increment depth every time we . this file, at the end of any script
# that .'s this file, there should be a call to common_finish to decrement.
push_common
