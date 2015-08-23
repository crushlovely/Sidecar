# ![icon](sidecar-120.png) Sidecar [![Build Status](http://img.shields.io/travis/crushlovely/Sidecar.svg?style=flat)](https://travis-ci.org/crushlovely/Sidecar) [![Coverage Status](http://img.shields.io/coveralls/crushlovely/Sidecar.svg?style=flat)](https://coveralls.io/r/crushlovely/Sidecar)

<!--
[![Version](http://cocoapod-badges.herokuapp.com/v/Sidecar/badge.png)](http://cocoadocs.org/docsets/Sidecar)
[![Platform](http://cocoapod-badges.herokuapp.com/p/Sidecar/badge.png)](http://cocoadocs.org/docsets/Sidecar)
-->

Yet another utility belt for iOS projects. Sidecar aims to be small, well-tested, and non-invasive.

## Features
* Category methods for commonly needed functionality (trimming a string, creating UIColors from hex, generating digests of data, etc.).
# A bunch fo category methods for building up attributed strings.
# A small library of useful geometry routines -- linear interpolation, range mapping, etc.
* A few simple UIView subclasses to make dealing with non-standard `+layerClass`es easier.
* A log formatter for [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) that includes the method and filename in log messages.
* A wrapper for [`tgmath.h`](http://libreprogramming.org/books/c/tgmath/) to work around a bug with tgmath and Clang modules (`-fmodules`).
* A featureful object wrapper around the AudioToolbox [system sound API](https://developer.apple.com/library/ios/documentation/AudioToolbox/Reference/SystemSoundServicesReference/Reference/reference.html) for playing short sound effects.
* Well-documented and tested. (Note that the test coverage percentage is higher than appears in the badge above; Travis CI's virtual machines can't run tests on the audio components of Sidecar.)

## Installation
Sidecar is available through [CocoaPods](http://cocoapods.org). You can use it by adding the following line to your Podfile:

    pod 'Sidecar'

## License
Sidecar is available under the MIT license. See the LICENSE file for more info.

## Acknowledgements
The lovely icon was created by [Ray Bruwelheide](http://ray-b.net). It is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/).
