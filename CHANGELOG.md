# Sidecar CHANGELOG

## 1.1.0 - 25 Oct. 2015

* Rewrote CRLSystemSound to use the new completion block API in iOS 9. That class now requires iOS 9, but no external API changed.

## 1.0.0 - 15 Sept. 2015

Big update. Now requires Xcode 7
* Added a bunch of useful things from recent projects -- a ton of attributed string stuff, HMAC, some geometry functions.
* Added nullability annotations and Obj-C generics for Swift support (hence the Xcode 7 requirement).
* Removed some old code coverage cruft, now that Xcode 7 does it better.
* Updated logging stuff to CocoaLumberjack 2.
* CocoaLumberjack is now an optional dependency.
* Tests reorganized and expanded.


## 0.1.0

Initial release.
