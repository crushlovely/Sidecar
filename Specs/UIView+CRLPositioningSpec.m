// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "UIView+CRLPositioning.h"

// TODO: write a nice matcher for these?
#define expectEqualRects(r1, r2) \
    do { \
        expect(  CGRectGetMinX(r1)).to.equal(  CGRectGetMinX(r2)); \
        expect(  CGRectGetMinY(r1)).to.equal(  CGRectGetMinY(r2)); \
        expect( CGRectGetWidth(r1)).to.equal( CGRectGetWidth(r2)); \
        expect(CGRectGetHeight(r1)).to.equal(CGRectGetHeight(r2)); \
    } while(0)

#define expectEqualPoints(p1, p2) \
    do { \
        expect(p1.x).to.equal(p2.x); \
        expect(p1.y).to.equal(p2.y); \
    } while(0)

#define expectEqualSizes(s1, s2) \
    do { \
        expect(s1.width).to.equal(s2.width); \
        expect(s1.height).to.equal(s2.height); \
    } while(0)


SpecBegin(CRLPositioning)

describe(@"firstSubviewOfKind", ^{
    __block UIView *parent;
    __block UILabel *child;

    beforeEach(^{
        parent = [[UIView alloc] initWithFrame:CGRectZero];
        child = [[UILabel alloc] initWithFrame:CGRectZero];
        [parent addSubview:child];
    });


    it(@"should return the first subview of the given class", ^{
        expect([parent crl_firstSubviewOfKind:[UILabel class]]).to.beIdenticalTo(child);
    });

    it(@"should return nil if there is no matching subview", ^{
        expect([parent crl_firstSubviewOfKind:[UIButton class]]).to.beNil();
    });

    it(@"should match subclasses of the given class", ^{
        expect([parent crl_firstSubviewOfKind:[UIView class]]).to.beIdenticalTo(child);
    });
});


describe(@"z-order functions", ^{
    __block UIView *parent;
    __block UIView *childA, *childB;

    beforeEach(^{
        parent = [[UIView alloc] initWithFrame:CGRectZero];
        childA = [[UIView alloc] initWithFrame:CGRectZero];
        childB = [[UIView alloc] initWithFrame:CGRectZero];
        [parent addSubview:childA];
        [parent addSubview:childB];
    });

    describe(@"exchangeSubview:withSubview:", ^{
        it(@"should swap the index of two subviews", ^{
            [parent crl_exchangeSubview:childA withSubview:childB];

            NSUInteger childAIndex = [parent.subviews indexOfObject:childA];
            NSUInteger childBIndex = [parent.subviews indexOfObject:childB];
            expect(childAIndex).to.equal(1);
            expect(childBIndex).to.equal(0);
        });

        it(@"should do nothing when given a view that does not have the same superview", ^{
            UIView *otherView = [[UIView alloc] initWithFrame:CGRectZero];
            [parent crl_exchangeSubview:otherView withSubview:childA];
            expect([parent.subviews indexOfObject:childA]).to.equal(0);

            [parent crl_exchangeSubview:childA withSubview:otherView];
            expect([parent.subviews indexOfObject:childA]).to.equal(0);
        });

        it(@"should do nothing when given nils", ^{
            [parent crl_exchangeSubview:nil withSubview:childA];
            expect([parent.subviews indexOfObject:childA]).to.equal(0);

            [parent crl_exchangeSubview:nil withSubview:childA];
            expect([parent.subviews indexOfObject:childA]).to.equal(0);

            [parent crl_exchangeSubview:nil withSubview:nil];
            expect([parent.subviews indexOfObject:childA]).to.equal(0);
            expect([parent.subviews indexOfObject:childB]).to.equal(1);
        });
    });

    describe(@"subview:isInFrontOfSubview:", ^{
        it(@"should return the correct result based on subview indices", ^{
            expect([parent crl_subview:childB isInFrontOfSubview:childA]).to.beTruthy();
            expect([parent crl_subview:childA isInFrontOfSubview:childB]).to.beFalsy();
        });

        it(@"should return NO for unrelated views or nil", ^{
            UIView *otherView = [[UIView alloc] initWithFrame:CGRectZero];
            expect([parent crl_subview:childA isInFrontOfSubview:otherView]).to.beFalsy();
            expect([parent crl_subview:otherView isInFrontOfSubview:childA]).to.beFalsy();

            expect([parent crl_subview:nil isInFrontOfSubview:childA]).to.beFalsy();
            expect([parent crl_subview:childA isInFrontOfSubview:nil]).to.beFalsy();
        });
    });
});


describe(@"frame manipulation", ^{
    __block UIView *view;

    beforeEach(^{
        view = [[UIView alloc] initWithFrame:CGRectZero];
    });

    it(@"should pass through frame setters/getters", ^{
        view.crl_origin = CGPointMake(1.0, 2.0);
        expectEqualRects(view.frame, CGRectMake(1.0, 2.0, 0, 0));
        expectEqualPoints(view.crl_origin, CGPointMake(1.0, 2.0));

        view.crl_x = 3.0;
        expectEqualRects(view.frame, CGRectMake(3.0, 2.0, 0, 0));
        expect(view.crl_x).to.equal(3.0);

        view.crl_y = 4.0;
        expectEqualRects(view.frame, CGRectMake(3.0, 4.0, 0, 0));
        expect(view.crl_y).to.equal(4.0);

        view.crl_size = CGSizeMake(1.0, 2.0);
        expectEqualRects(view.frame, CGRectMake(3.0, 4.0, 1.0, 2.0));
        expectEqualSizes(view.crl_size, CGSizeMake(1.0, 2.0));

        view.crl_width = 6.0;
        expectEqualRects(view.frame, CGRectMake(3.0, 4.0, 6.0, 2.0));
        expect(view.crl_width).to.equal(6.0);

        view.crl_height = 7.0;
        expectEqualRects(view.frame, CGRectMake(3.0, 4.0, 6.0, 7.0));
        expect(view.crl_height).to.equal(7.0);
    });

    it(@"should allow edge manipulation", ^{
        view.frame = CGRectMake(0, 0, 10.0, 20.0);

        view.crl_topLeft = CGPointMake(1.0, 2.0);
        expectEqualRects(view.frame, CGRectMake(1.0, 2.0, 10.0, 20.0));
        expectEqualPoints(view.crl_topLeft, CGPointMake(1.0, 2.0));

        view.crl_top = 5.0;
        expectEqualRects(view.frame, CGRectMake(1.0, 5.0, 10.0, 20.0));
        expect(view.crl_top).to.equal(5.0);

        view.crl_left = 10.0;
        expectEqualRects(view.frame, CGRectMake(10.0, 5.0, 10.0, 20.0));
        expect(view.crl_left).to.equal(10.0);


        view.crl_topRight = CGPointMake(50.0, 2.0);
        expectEqualRects(view.frame, CGRectMake(40.0, 2.0, 10.0, 20.0));
        expectEqualPoints(view.crl_topRight, CGPointMake(50.0, 2.0));

        view.crl_right = 60.0;
        expectEqualRects(view.frame, CGRectMake(50.0, 2.0, 10.0, 20.0));
        expect(view.crl_right).to.equal(60.0);


        view.crl_bottomLeft = CGPointMake(1.0, 40.0);
        expectEqualRects(view.frame, CGRectMake(1.0, 20.0, 10.0, 20.0));
        expectEqualPoints(view.crl_bottomLeft, CGPointMake(1.0, 40.0));

        view.crl_bottom = 80.0;
        expectEqualRects(view.frame, CGRectMake(1.0, 60.0, 10.0, 20.0));
        expect(view.crl_bottom).to.equal(80.0);


        view.crl_bottomRight = CGPointMake(50.0, 90.0);
        expectEqualRects(view.frame, CGRectMake(40.0, 70.0, 10.0, 20.0));
        expectEqualPoints(view.crl_bottomRight, CGPointMake(50.0, 90.0));
    });

    it(@"should handle denormal rects", ^{
        view.frame = CGRectMake(0, 0, -50, -20);
        expectEqualPoints(view.crl_origin, CGPointMake(-50, -20));
        expectEqualSizes(view.crl_size, CGSizeMake(50, 20));
    });
});

SpecEnd
