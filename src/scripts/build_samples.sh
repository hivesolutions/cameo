#!/bin/sh

# Hive Cameo Framework
# Copyright (C) 2008-2014 Hive Solutions Lda.
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
# __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
# __license__   = GNU General Public License (GPL), Version 3

. ${CAMEO_SDK_SCRIPT:-$(dirname $0)}/common.sh

# valid arguments are: no-value, "Debug" and "Release" (default)
BUILDCONFIGURATION=${1:-Release}

test -x "$XCODEBUILD" || die 'Could not find xcodebuild in $PATH'

progress_message Building samples.

# calls out to build .framework
if is_outermost_build; then
  . $CAMEO_SDK_SCRIPT/build_framework.sh
fi

# certain subdirs of samples are not samples to be built,
# excludes them from the find query
FB_SAMPLES_EXCLUDED=(FBConnect.bundle)
for excluded in "${FB_SAMPLES_EXCLUDED[@]}"; do
  if [ -n "$FB_FIND_ARGS" ]; then
    FB_FIND_ARGS="$FB_FIND_ARGS -o"
  fi
  FB_FIND_ARGS="$FB_FIND_ARGS -name $excluded"
done

FB_FIND_SAMPLES_CMD="find $CAMEO_SDK_SAMPLES -type d -depth 1 ! ( $FB_FIND_ARGS )"

# builds each of the sample project into
# the defined directories
function xcode_build_sample() {
  cd $CAMEO_SDK_SAMPLES/$1
  progress_message "Compiling '${1}' for platform '${2}' using configuration '${3}'."
  $XCODEBUILD \
    -alltargets \
    -sdk $2 \
    -configuration "${3}" \
    SYMROOT=$CAMEO_SDK_BUILD \
    CURRENT_PROJECT_VERSION=$CAMEO_SDK_VERSION_FULL \
    clean build \
    || die "XCode build failed for sample '${1}' on platform: ${2}."
}

for sampledir in `$FB_FIND_SAMPLES_CMD`; do
  xcode_build_sample `basename $sampledir` "iphonesimulator" "$BUILDCONFIGURATION"
done

common_success
