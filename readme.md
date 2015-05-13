# [![Cameo Framework](res/logo.png)](http://cameo.hive.pt)

A generic framework for ios interaction that provides a series of utilities.

## Adding header file

In order to add an header file to the project and still be able to run the build
scripts correctly one must set the target membership of the header file as **public**.

## Build & Installation

Install build dependencies **appledoc** and **packagemaker**, this are required
for the correct execution of the `build_all.sh` script:

    brew install appledoc

The packagemaker must be installed with the **Auxiliary Tools** for Xcode from
[Downloads for Apple Developers](https://developer.apple.com/downloads).

Deploy the PackageMaker app to the `XcodeTools` folder.

    cp -rp * /Applications/XcodeTools

Then use the following command to create a valid symbolic link to the package maker.

    ln -s /Applications/XcodeTools/PackageMaker.app/Contents/MacOS/PackageMaker /usr/bin/packagemaker

Clone the current cameo repository to get its source data with:

    git clone https://github.com/hivesolutions/cameo.git

Execute the build script with:

    sh src/scripts/build_all.sh

## Cocoa Pods usage

To publish the Cameo Framework to the trunk repo of Cocoa Pods use:

    pod trunk push Cameo.podspec

If the "private" Hive Solutions repo is the target use instead:

    pod repo push hive cameo.podspe
    
## License

Appier is currently licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/).

## Build Automation

[![CocoaPods Status](https://cocoapod-badges.herokuapp.com/v/Cameo/badge.png)](http://cocoadocs.org/docsets/Cameo)
