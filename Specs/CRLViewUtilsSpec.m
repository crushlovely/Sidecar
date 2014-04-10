// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

Class ___mockScreenClass;

#define UIScreen ___mockScreenClass
#import "CRLViewUtils.h"
#undef UIScreen

SpecBegin(CRLViewUtils)

beforeAll(^{
    UIScreen *mockScreen = mock([UIScreen class]);
    [given([mockScreen scale]) willReturnFloat:3.0];  // Faking a nonexistent scale to test genericity of support

    ___mockScreenClass = mockClass([UIScreen class]);
    [given([___mockScreenClass mainScreen]) willReturn:mockScreen];
});

it(@"should return the proper number of points per pixel", ^{
    expect(CRLSizeOfPixelInPoints()).to.equal(1.0 / 3.0);
});

it(@"should round non-pixel-integral values away from zero", ^{
    expect(CRLRoundToNearestPixel(2.5)).to.equal(2 + 2 / 3.0);
    expect(CRLRoundToNearestPixel(2.8)).to.equal(3.0);
    expect(CRLRoundToNearestPixel(3.0)).to.equal(3.0);
    expect(CRLRoundToNearestPixel(0.0)).to.equal(0.0);
    expect(CRLRoundToNearestPixel(-1.0)).to.equal(-1.0);
    expect(CRLRoundToNearestPixel(-3.2)).to.equal(-3 - 1 / 3.0);
    expect(CRLRoundToNearestPixel(-2.8)).to.equal(-3.0);
});

it(@"should round both components of a point", ^{
    CGPoint pt = CRLRoundPointToNearestPixel(CGPointMake(2.5, -3.2));
    expect(pt.x).to.equal(2 + 2 / 3.0);
    expect(pt.y).to.equal(-3 - 1 / 3.0);
});

SpecEnd