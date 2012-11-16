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
test -x "$PACKAGEMAKER" || die 'Could not find packagemaker in $PATH'

CAMEO_SDK_PKG=$CAMEO_SDK_BUILD/Cameo-${CAMEO_SDK_VERSION_FULL}.pkg
CAMEO_SDK_FRAMEWORK_TGZ=${CAMEO_SDK_FRAMEWORK}-${CAMEO_SDK_VERSION_FULL}.tgz

CAMEO_SDK_BUILD_PACKAGE=$CAMEO_SDK_BUILD/package
CAMEO_SDK_BUILD_PACKAGE_FRAMEWORK_SUBDIR=Documents/Cameo
CAMEO_SDK_BUILD_PACKAGE_FRAMEWORK=$CAMEO_SDK_BUILD_PACKAGE/$CAMEO_SDK_BUILD_PACKAGE_FRAMEWORK_SUBDIR
CAMEO_SDK_BUILD_PACKAGE_SAMPLES=$CAMEO_SDK_BUILD_PACKAGE/Documents/Cameo/Samples
CAMEO_SDK_BUILD_PACKAGE_DOCS=$CAMEO_SDK_BUILD_PACKAGE/Library/Developer/Shared/Documentation/DocSets/$CAMEO_SDK_DOCSET_NAME

# checks for the required execution and executes
# but only in case it's not the outermost build
if is_outermost_build; then
    . $CAMEO_SDK_SCRIPT/build_framework.sh
    . $CAMEO_SDK_SCRIPT/build_documentation.sh
fi
echo Building Distribution.

# compress framework for standalone distribution
progress_message "Compressing framework for standalone distribution."
\rm -rf ${CAMEO_SDK_FRAMEWORK_TGZ}

# must change to the build directory for the tar
# execution (only executes in the current directory)
cd $CAMEO_SDK_BUILD || die "Could not cd to $CAMEO_SDK_BUILD"
tar -c -z $CAMEO_SDK_FRAMEWORK_NAME >  $CAMEO_SDK_FRAMEWORK_TGZ \
  || die "tar failed to create ${CAMEO_SDK_FRAMEWORK_NAME}.tgz"

# builds the complete package directory structure
progress_message "Building package directory structure."
\rm -rf $CAMEO_SDK_BUILD_PACKAGE
mkdir $CAMEO_SDK_BUILD_PACKAGE \
  || die "Could not create directory $CAMEO_SDK_BUILD_PACKAGE"
mkdir -p $CAMEO_SDK_BUILD_PACKAGE_FRAMEWORK
mkdir -p $CAMEO_SDK_BUILD_PACKAGE_SAMPLES
mkdir -p $CAMEO_SDK_BUILD_PACKAGE_DOCS

\cp -R $CAMEO_SDK_FRAMEWORK $CAMEO_SDK_BUILD_PACKAGE_FRAMEWORK \
  || die "Could not copy $CAMEO_SDK_FRAMEWORK"
\cp -R $CAMEO_SDK_SAMPLES/ $CAMEO_SDK_BUILD_PACKAGE_SAMPLES \
  || echo "Could not copy $CAMEO_SDK_BUILD_PACKAGE_SAMPLES"
\cp -R $CAMEO_SDK_FRAMEWORK_DOCS/docset/Contents $CAMEO_SDK_BUILD_PACKAGE_DOCS \
  || echo "Could not copy $$CAMEO_SDK_FRAMEWORK_DOCS/docset/Contents"

# runs the fixup projects to point to the framework
for fname in $(find $CAMEO_SDK_BUILD_PACKAGE_SAMPLES -name "project.pbxproj" -print); do \
  sed "s|../../build|../../../../${CAMEO_SDK_BUILD_PACKAGE_FRAMEWORK_SUBDIR}|g" \
    ${fname} > ${fname}.tmpfile  && mv ${fname}.tmpfile ${fname}; \
done

# builds the package using the currently defined
# configuration file for the cameo
progress_message "Building .pkg from package directory."
\rm -rf $CAMEO_SDK_PKG
$PACKAGEMAKER \
  --doc $CAMEO_SDK_SRC/src/package/Cameo.pmdoc \
  --domain user \
  --target 10.5 \
  --version $CAMEO_SDK_VERSION \
  --out $CAMEO_SDK_PKG \
  --title 'Cameo Framework 0.1.0 for iOS' \
  || die "PackageMaker reported error"

progress_message "Successfully built SDK distribution:"
progress_message "  $CAMEO_SDK_FRAMEWORK_TGZ"
progress_message "  $CAMEO_SDK_PKG"
common_success
