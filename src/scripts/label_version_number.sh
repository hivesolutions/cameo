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

. ${CAMEO_SDK_SCRIPT:-$(dirname $0)}/common.sh

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 MAJOR MINOR [HOTFIX [BETA]]"
    echo "  MAJOR         major version number"
    echo "  MINOR         minor version number"
    echo "  HOTFIX        hotfix version number"
    echo "  BETA          'b' if this is a beta release"
    die 'Arguments do not conform to usage'
fi

cd $CAMEO_SDK_SRC

VERSION_STRING="$1"."$2"

if [ "$3" != "" ]; then
    VERSION_STRING="$VERSION_STRING"."$3"
fi
if [ "$4" != "" ]; then
    # We actually append 'b' regardless of what was passed.
    VERSION_STRING="$VERSION_STRING".b
fi

TAG_NAME=sdk-version-"$VERSION_STRING"

git tag -a "$TAG_NAME" HEAD \
    || die 'Failed to tag HEAD. If this is a duplicate tag, please delete the old one first.'

progress_message "Tagged HEAD as $TAG_NAME"
progress_message "Be sure to use 'git push --tags' in order to push tags upstream."

common_success
