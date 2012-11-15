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

# This script builds the FacebookSDK.framework, all samples, and the distribution package.

. ${CAMEO_SDK_SCRIPT:-$(dirname $0)}/common.sh

# -----------------------------------------------------------------------------
# Call out to build .framework
#
. $CAMEO_SDK_SCRIPT/build_framework.sh

# -----------------------------------------------------------------------------
# Build docs
#
#. $CAMEO_SDK_SCRIPT/build_documentation.sh

# -----------------------------------------------------------------------------
# Call out to build samples (suppress building framework)
#
#. $CAMEO_SDK_SCRIPT/build_samples.sh Release
#. $CAMEO_SDK_SCRIPT/build_samples.sh Debug

# -----------------------------------------------------------------------------
# Call out to build distribution (suppress building framework)
#
. $CAMEO_SDK_SCRIPT/build_distribution.sh

common_success
