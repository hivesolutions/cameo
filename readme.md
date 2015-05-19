# [![Cameo Framework](res/logo.png)](http://cameo.hive.pt)

A generic framework for ios interaction that provides a series of utilities.

## Adding header file

In order to add an header file to the project and still be able to run the build
scripts correctly one must set the target membership of the header file as **public**.

### Installation

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Cameo in your projects.

#### Podfile

```ruby
platform :ios, '7.0'
pod "Cameo"
```

## CocoaPods usage

To publish the Cameo Framework to the trunk repo of Cocoa Pods use:

    pod trunk push Cameo.podspec

If the "private" Hive Solutions repo is the target use instead:

    pod repo push hive Cameo.podspec

## License

Appier is currently licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/).

## Build Automation

[![Build Status](https://travis-ci.org/hivesolutions/cameo.png?branch=master)](https://travis-ci.org/hivesolutions/cameo)
[![CocoaPods Status](https://cocoapod-badges.herokuapp.com/v/Cameo/badge.png)](http://cocoadocs.org/docsets/Cameo)
