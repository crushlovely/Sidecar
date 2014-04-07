//
//  CRLGradientLayerViewSpec.m
//  Sidecar
//
//  Created by Tim Clem on 3/28/14.
//  Copyright (c) 2014 Crush & Lovely. All rights reserved.
//

#import "CRLGradientLayerView.h"

EXPMatcherInterface(haveElementsEqualTo, (NSArray *expected));

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


SpecBegin(CRLGradientLayerView)

it(@"should have a CAGradientLayer layer", ^{
    CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
    expect(view.layer).to.beKindOf([CAGradientLayer class]);
});

it(@"should pass through its layer via the gradientLayer property", ^{
    CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
    expect(view.gradientLayer).to.beIdenticalTo(view.layer);
});

it(@"should pass gradient colors to the layer and back", ^{
    CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
    view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];

    expect(((CAGradientLayer *)view.layer).colors).to.haveElementsEqualTo(@[ (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor ]);
    expect(view.gradientColors).to.haveElementsEqualTo(@[ [UIColor redColor], [UIColor blueColor] ]);
});

it(@"should pass gradient locations to the layer and back", ^{
    CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
    view.gradientLocations = @[ @0.0, @0.5, @1.0 ];

    expect(((CAGradientLayer *)view.layer).locations).to.haveElementsEqualTo(@[ @0.0, @0.5, @1.0 ]);
    expect(view.gradientLocations).to.haveElementsEqualTo(@[ @0.0, @0.5, @1.0 ]);
});

it(@"should clear backgroundColor when setting gradientColors", ^{
    CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor redColor];
    view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];

    expect(view.backgroundColor).to.equal([UIColor clearColor]);
});

it(@"should clear gradientColors when setting backgroundColor", ^{
    CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
    view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];
    view.backgroundColor = [UIColor redColor];

    expect(view.gradientColors).to.beNil();
});

it(@"should clear gradientColors when set to nil or an empty array", ^{
    CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
    view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];

    view.gradientColors = nil;
    expect(view.gradientColors).to.beNil();

    view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];
    view.gradientColors = @[];
    expect(view.gradientColors).to.beNil();
});

SpecEnd