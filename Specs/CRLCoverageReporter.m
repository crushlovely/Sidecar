//
//  CRLCoverageReporter.m
//  Sidecar
//
//  Created by Tim Clem on 4/5/14.
//  Copyright (c) 2014 Crush & Lovely. All rights reserved.
//

// This is to work around an issue where apps run in the iOS 7 simulator don't terminate
// in such a away that the coverage files are actually generated.
// See the discussion and answer here: http://stackoverflow.com/a/20267421
// Since this is a static library, we don't have a UIApplication to inject into,
// so we can do the __gcov_flush() call directly in -stopObserving.
// Also we're using +load to set the environmental variable for Specta, rather than making
// it part of the configuration.


#import <Specta/SPTNestedReporter.h>

extern void __gcov_flush(void);


@interface CRLCoverageReporter : SPTNestedReporter
@end


@implementation CRLCoverageReporter

+(void)load
{
    setenv("SPECTA_REPORTER_CLASS", "CRLCoverageReporter", 1);
}

-(void)stopObserving
{
    [super stopObserving];

    __gcov_flush();
}

@end