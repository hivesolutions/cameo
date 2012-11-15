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

import sys
import json
import httplib

if len(sys.argv) == 3:
    appId = sys.argv[1]
    appSecret = sys.argv[2]
    print("Deleting test users for app " + appId)
else:
    print("Must specify appId and appSecret.")
    exit(-1)

host = "graph.facebook.com"
fmtGet = "/{0}/accounts/test-users?access_token={0}|{1}"
fmtDel = "/{0}?method=delete&access_token={1}|{2}"

usersPath = fmtGet.format(appId, appSecret)

while usersPath:
    print("Getting users via: " + usersPath)
    conn = httplib.HTTPSConnection(host)
    conn.request("GET", usersPath)
    users = json.loads(conn.getresponse().read())
    print "Got", len(users["data"]), "users."

    for user in users["data"]:
        print("Deleting user {0}".format(user["id"]))
        delPath = fmtDel.format(user["id"], appId, appSecret)
        conn = httplib.HTTPSConnection(host)
        conn.request("GET", delPath)
        deleteResult = conn.getresponse().read()
        if (deleteResult <> "true"):
            print("delete failed, got " + deleteResult)

    if not "paging" in users: break
    paging = users["paging"]

    if not "next" in users["paging"]: break
    nextUrl = paging["next"]
    prefix = "https://graph.facebook.com"

    if not nextUrl.startswith(prefix):
        print("Paging url does not start with " + prefix)
        break

    usersPath = nextUrl[len(prefix):]
    print("Continuing next page at: " + usersPath)
