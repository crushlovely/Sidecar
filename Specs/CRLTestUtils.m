//
//  CRLTestUtils.m
//  Sidecar
//
//  Created by Timothy Clem on 8/23/15.
//  Copyright © 2015 Crush & Lovely. All rights reserved.
//

#import "CRLTestUtils.h"

EXPMatcherImplementationBegin(haveElementsEqualTo, (NSArray *expected)) {
    NSArray *actualArray = (NSArray *)actual;
    __block NSUInteger indexOfMismatch;
    __block id expectedElement, actualElement;

    prerequisite(^BOOL {
        return expected && [actual isKindOfClass:[NSArray class]];
    });

    match(^BOOL {
        if(actualArray.count != expected.count) return NO;

        for(NSUInteger i = 0; i < actualArray.count; i++) {
            if(![actualArray[i] isEqual:expected[i]]) {
                indexOfMismatch = i;
                expectedElement = expected[i];
                actualElement = actualArray[i];

                return NO;
            }
        }

        return YES;
    });

    failureMessageForTo(^NSString * {
        if(!expected) return @"the expected value is nil/null";

        if(!actual)
            return @"the actual value is nil/null";

        if(![actual isKindOfClass:[NSArray class]])
            return [NSString stringWithFormat:@"the actual value is an instance of %@, which is not an NSArray", [actual class]];

        if(actualArray.count != expected.count)
            return [NSString stringWithFormat:@"expected: an array of count %lu, got: an array of count %lu", (unsigned long)expected.count, (unsigned long)actualArray.count];

        return [NSString stringWithFormat:@"expected: element at index %lu to equal %@, got: %@", (unsigned long)indexOfMismatch, expectedElement, actualElement];
    });
}
EXPMatcherImplementationEnd
