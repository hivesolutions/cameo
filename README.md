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

To publish the Cameo Framework to the trunk repo of CocoaPods use:

    pod trunk push Cameo.podspec

If the "private" Hive Solutions repo is the target use instead:

    pod repo push hive Cameo.podspec

## Travis automation

To be able to publish the package directly to CocoPods one must use register first with the trunk

    pod trunk register joamag@hive.pt "João Magalhães"

And then use the token located at `~/.netrc` to create the `COCOAPODS_TRUNK_TOKEN` environment variable in `.travis.yml`.

Then this same environment setting must be encrypted using the tavis strartegy:

    travis encrypt COCOAPODS_TRUNK_TOKEN=your_cocoapods_token

## License

Appier is currently licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/).

## Build Automation

[![Build Status](https://travis-ci.org/hivesolutions/cameo.svg?branch=master)](https://travis-ci.org/hivesolutions/cameo)
[![CocoaPods Status](https://cocoapod-badges.herokuapp.com/v/Cameo/badge.png)](https://cocoapods.org/pods/Cameo)
