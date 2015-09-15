// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>
#import <Swizzlean/Swizzlean.h>

#import "CRLViewUtils.h"

SpecBegin(CRLViewUtils)

describe(@"CRLViewUtils", ^{
    __block Swizzlean *screenScaleSwizzle;

    beforeAll(^{
        screenScaleSwizzle = [[Swizzlean alloc] initWithClassToSwizzle:[UIScreen class]];
        [screenScaleSwizzle swizzleInstanceMethod:@selector(scale) withReplacementImplementation:^{
            return 5.0;  // Using a bogus value to test genericity of implementation
        }];
    });

    it(@"should return the proper number of points per pixel", ^{
        expect(CRLSizeOfPixelInPoints()).to.equal(1.0 / 5.0);
    });

    it(@"should round non-pixel-integral values away from zero", ^{
        expect(CRLRoundToNearestPixel(2.5)).to.equal(2.6);
        expect(CRLRoundToNearestPixel(2.9)).to.equal(3.0);
        expect(CRLRoundToNearestPixel(3.0)).to.equal(3.0);
        expect(CRLRoundToNearestPixel(0.0)).to.equal(0.0);
        expect(CRLRoundToNearestPixel(-1.0)).to.equal(-1.0);
        expect(CRLRoundToNearestPixel(-3.2)).to.equal(-3.2);
        expect(CRLRoundToNearestPixel(-2.9)).to.equal(-3.0);
    });

    it(@"should round both components of a point", ^{
        CGPoint pt = CRLRoundPointToNearestPixel(CGPointMake(2.5, -2.9));
        expect(pt.x).to.equal(2.6);
        expect(pt.y).to.equal(-3.0);
    });

    afterAll(^{
        [screenScaleSwizzle resetSwizzledInstanceMethod];
        screenScaleSwizzle = nil;
    });
});

SpecEnd