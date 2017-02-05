//
//  CRLTestUtils.h
//  Sidecar
//
//  Created by Timothy Clem on 8/23/15.
//  Copyright © 2015 Crush & Lovely. All rights reserved.
//

#import <UIKit/UIKit.h>

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


EXPMatcherInterface(haveElementsEqualTo, (NSArray *expected));
