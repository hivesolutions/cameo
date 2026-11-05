# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

*

### Changed

*

### Fixed

*

## [0.6.0] - 2026-11-05

### Added

* Apps can provide their own login screen

### Changed

* Requires iOS 15 or later
* Error messages use the modern iOS alert style

### Fixed

* Login screen can no longer be swiped away, and the screen behind it reloads after signing in
* Layout no longer sits under the notch or Dynamic Island on recent iPhones
* Passwords containing characters such as & or + now sign in correctly
* Crash when an error message or store name is empty
* Login no longer opens twice when several requests need a session

## [0.5.2] - 2022-02-06

### Fixed

* Issue related with double deployment to CocoaPods

## [0.5.1] - 2022-02-06

### Fixed

* Issues related with CI/CD

## [0.5.0] - 2022-02-05

### Fixed

* Issues related with the `UITextField`
