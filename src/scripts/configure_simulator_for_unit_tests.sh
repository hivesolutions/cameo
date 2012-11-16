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
      echo "Usage: $0 APP_ID APP_SECRET [MACHINE_UNIQUE_USER_KEY]"
      echo "  APP_ID                   your unit-testing Facebook application's App ID"
      echo "  APP_SECRET               your unit-testing Facebook application's App Secret"
      echo "  MACHINE_UNIQUE_USER_TAG  optional text used to ensure this machine will use its own set of test users rather than sharing"
      die 'Arguments do not conform to usage'
fi

function write_plist {
      SIMULATOR_CONFIG_DIR="$1"/Documents
      SIMULATOR_CONFIG_FILE="$SIMULATOR_CONFIG_DIR"/FacebookSDK-UnitTestConfig.plist

      if [ ! -d "$SIMULATOR_CONFIG_DIR" ]; then
            mkdir "$SIMULATOR_CONFIG_DIR"
      fi

      cat > "$SIMULATOR_CONFIG_FILE" \
<<DELIMIT
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>FacebookAppID</key>
        <string>$2</string>
        <key>FacebookAppSecret</key>
        <string>$3</string>
        <key>UniqueUserTag</key>
        <string>$4</string>
</dict>
</plist>
DELIMIT

      echo "wrote unit test config file at $SIMULATOR_CONFIG_FILE" 
}

SIMULATOR_DIR=$HOME/Library/Application\ Support/iPhone\ Simulator

test -x "$SIMULATOR_DIR" || die 'Could not find simulator directory'

write_plist "$SIMULATOR_DIR" $1 $2 $3

for VERSION_DIR in "${SIMULATOR_DIR}"/[456].*; do
      write_plist "$VERSION_DIR" $1 $2 $3
done
