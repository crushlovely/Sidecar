// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

@protocol DDLogFormatter;

/**
 A CocoaLumberjack log formatter that includes the date, time, filename, function name
 (or selector name), and log level.
 */
@interface CRLMethodLogFormatter : NSObject <DDLogFormatter>

@end
