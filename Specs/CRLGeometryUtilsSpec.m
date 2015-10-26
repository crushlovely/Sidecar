// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "Specta.h"
#import "CRLGeometryUtils.h"
#import "CRLTestUtils.h"


SpecBegin(CRLGeometryUtils)

describe(@"CRLLerp", ^{
    it(@"should linearly interpolate a CGFloat", ^{
        expect(CRLLerp(0, 5, 0)).to.equal(0);
        expect(CRLLerp(0, 5, 1)).to.equal(5);
        expect(CRLLerp(0, 5, 0.5)).to.equal(2.5);
    });

    it(@"should linearly interpolate a CGSize", ^{
        expectEqualSizes(CRLLerp(CGSizeMake(0, 0), CGSizeMake(5, 10), 0),
                         CGSizeMake(0, 0));
        expectEqualSizes(CRLLerp(CGSizeMake(0, 0), CGSizeMake(5, 10), 1),
                         CGSizeMake(5, 10));
        expectEqualSizes(CRLLerp(CGSizeMake(0, 0), CGSizeMake(5, 10), 0.5),
                         CGSizeMake(2.5, 5));
    });

    it(@"should linearly interpolate a CGPoint", ^{
        expectEqualPoints(CRLLerp(CGPointMake(0, 0), CGPointMake(5, 10), 0),
                          CGPointMake(0, 0));
        expectEqualPoints(CRLLerp(CGPointMake(0, 0), CGPointMake(5, 10), 1),
                          CGPointMake(5, 10));
        expectEqualPoints(CRLLerp(CGPointMake(0, 0), CGPointMake(5, 10), 0.5),
                          CGPointMake(2.5, 5));
    });

    it(@"should linearly interpolate a CGRect", ^{
        expectEqualRects(CRLLerp(CGRectZero, CGRectMake(5, 10, 15, 20), 0),
                         CGRectZero);
        expectEqualRects(CRLLerp(CGRectZero, CGRectMake(5, 10, 15, 20), 1),
                         CGRectMake(5, 10, 15, 20));
        expectEqualRects(CRLLerp(CGRectZero, CGRectMake(5, 10, 15, 20), 0.5),
                         CGRectMake(2.5, 5, 7.5, 10));
    });
});

describe(@"CRLMapRange", ^{
    it(@"should map a value from one range onto another", ^{
        expect(CRLMapRange(5, 0, 10, 10, 20, NO)).to.equal(15);
    });

    it(@"should properly handle negative values", ^{
        expect(CRLMapRange(-5, -10, 0, 0, 10, NO)).to.equal(5);
        expect(CRLMapRange(5, 0, 10, -10, 0, NO)).to.equal(-5);
        expect(CRLMapRange(0, -5, 5, 10, 20, NO)).to.equal(15);
    });

    it(@"should clamp values to the final range if specified", ^{
        expect(CRLMapRange(2, 0, 1, 0, 20, YES)).to.equal(20);
        expect(CRLMapRange(-1, 0, 1, 0, 20, YES)).to.equal(0);
    });

    it(@"should not clamp values to the final range if not specified", ^{
        expect(CRLMapRange(2, 0, 1, 0, 20, NO)).to.equal(40);
        expect(CRLMapRange(-1, 0, 1, 0, 20, NO)).to.equal(-20);
    });

    it(@"should handle the the min and max being flipped", ^{
        expect(CRLMapRange(2, 0, 10, 5, 0, YES)).to.equal(4);
        expect(CRLMapRange(25, 100, 0, 10, 0, YES)).to.equal(2.5);
    });
});

describe(@"CRLMapToPercentage", ^{
    it(@"should map a value from one range onto 0...1", ^{
        expect(CRLMapToPercentage(5, 0, 10, NO)).to.equal(0.5);
    });

    it(@"should properly handle negative values", ^{
        expect(CRLMapToPercentage(-5, -10, 0, NO)).to.equal(0.5);
        expect(CRLMapToPercentage(0, -10, 10, NO)).to.equal(0.5);
    });

    it(@"should clamp values if specified", ^{
        expect(CRLMapToPercentage(2, 0, 0.5, YES)).to.equal(1);
        expect(CRLMapToPercentage(-1, 0, 5, YES)).to.equal(0);
    });

    it(@"should not clamp values if not specified", ^{
        expect(CRLMapToPercentage(2, 0, 0.5, NO)).to.equal(4);
        expect(CRLMapToPercentage(-1, 0, 2, NO)).to.equal(-0.5);
    });
});

describe(@"CRLSizeForFittingSizeInSize", ^{
    it(@"should return the container size if the aspect ratios match", ^{
        expectEqualSizes(CRLSizeForFittingSizeInSize(CGSizeMake(100, 200), CGSizeMake(5, 10)),
                         CGSizeMake(5, 10));
    });

    it(@"should scale to the container width if the content is wider than it is tall", ^{
        expectEqualSizes(CRLSizeForFittingSizeInSize(CGSizeMake(200, 100), CGSizeMake(5, 10)),
                         CGSizeMake(5, 2.5));
    });

    it(@"should scale to the container height if the content is taller than it is wide", ^{
        expectEqualSizes(CRLSizeForFittingSizeInSize(CGSizeMake(100, 400), CGSizeMake(5, 10)),
                         CGSizeMake(2.5, 10));
    });
});

describe(@"CRLSizeForFillingSizeInSize", ^{
    it(@"should return the container size if the aspect ratios match", ^{
        expectEqualSizes(CRLSizeForFillingSizeInSize(CGSizeMake(100, 200), CGSizeMake(5, 10)),
                         CGSizeMake(5, 10));
    });

    it(@"should scale to the container height if the content is wider than it is tall", ^{
        expectEqualSizes(CRLSizeForFillingSizeInSize(CGSizeMake(200, 100), CGSizeMake(5, 10)),
                         CGSizeMake(20, 10));
    });

    it(@"should scale to the container width if the content is taller than it is wide", ^{
        expectEqualSizes(CRLSizeForFillingSizeInSize(CGSizeMake(100, 400), CGSizeMake(5, 10)),
                         CGSizeMake(5, 20));
    });
});

describe(@"CRLAspectRatio", ^{
    it(@"return the aspect ratio for a CGSize", ^{
        expect(CRLAspectRatio(CGSizeMake(10, 5))).to.equal(2);
    });

    it(@"return the aspect ratio for a CGRect", ^{
        expect(CRLAspectRatio(CGRectMake(0, 0, 10, 5))).to.equal(2);
    });

    it(@"return the aspect ratio for a UIImage", ^{
        UIGraphicsBeginImageContext(CGSizeMake(10, 5));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        expect(CRLAspectRatio(image)).to.equal(2);
    });

    it(@"return the aspect ratio for a UIView", ^{
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
        expect(CRLAspectRatio(v)).to.equal(2);
    });
});

SpecEnd
