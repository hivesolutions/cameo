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

# checks for the required execution and executes
# but only in case it's not the outermost build
if is_outermost_build; then
    . $CAMEO_SDK_SCRIPT/build_framework.sh -n
fi
progress_message Building Documentation.

# runs the building of the documentation
test -d $CAMEO_SDK_BUILD \
  || mkdir -p $CAMEO_SDK_BUILD \
  || die "Could not create directory $CAMEO_SDK_BUILD"

cd $CAMEO_SDK_SRC

APPLEDOC=appledoc
DOCSET="$CAMEO_SDK_BUILD"/"$CAMEO_SDK_DOCSET_NAME"

rm -rf $DOCSET

hash $APPLEDOC &>/dev/null
if [ "$?" -eq "0" ]; then
    APPLEDOC_DOCSET_NAME="Cameo Framework 0.1.0 for iOS"
    $APPLEDOC --project-name "$APPLEDOC_DOCSET_NAME" \
    --project-company "Cameo" \
    --company-id "pt.hive" \
    --output "$DOCSET" \
    --preprocess-headerdoc \
    --docset-bundle-name "$APPLEDOC_DOCSET_NAME" \
    --docset-feed-name "$APPLEDOC_DOCSET_NAME" \
    --exit-threshold 2 \
    --no-install-docset \
    --search-undocumented-doc \
    --keep-undocumented-members \
    --keep-undocumented-objects \
    --explicit-crossref \
    $CAMEO_SDK_FRAMEWORK/Headers \
    || die 'appledoc execution failed'
else
    die "appledoc not installed, unable to build documentation"
fi

# Temporary workaround to an appledoc bug that drops protocol names.
function replace_string() {
    perl -pi -e "s/$1/$2/" $3
}

DOCSDIR="$DOCSET"/docset/Contents/Resources/Documents

common_success
