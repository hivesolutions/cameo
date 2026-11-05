#!/bin/bash
# -*- coding: utf-8 -*-

# Prints the identifier (UDID) of an available iOS simulator whose name
# starts with the given family ("iPhone" by default, or "iPad"), using
# the newest iOS runtime installed. Device names change with every Xcode
# release, so CI resolves the simulator at run time instead of naming it.

family=${1:-iPhone}

xcrun simctl list devices available --json | python3 -c '
import json, re, sys
family = sys.argv[1]
devices = json.load(sys.stdin)["devices"]
def version(runtime):
    match = re.search(r"iOS-([0-9-]+)$", runtime)
    return [int(part) for part in match.group(1).split("-")] if match else None
runtimes = sorted((r for r in devices if version(r)), key=version, reverse=True)
for runtime in runtimes:
    for device in devices[runtime]:
        if device["name"].startswith(family):
            print(device["udid"])
            sys.exit(0)
sys.exit("No available %s simulator found" % family)
' "$family"
