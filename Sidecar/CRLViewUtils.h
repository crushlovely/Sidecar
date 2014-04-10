// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <UIKit/UIKit.h>
#import "tgmath-stopgap.h"

/**
 Returns the size of a pixel in points (e.g. 1 for non-retina screens, and
 0.5 for retina ones.)
 */
NS_INLINE CGFloat CRLSizeOfPixelInPoints(void)
{
    return 1.0 / [UIScreen mainScreen].scale;
}

/**
 Returns the given length (in points) rounded away from zero such that it falls on a
 "pixel-integral" value.
 
 For example: If passed 1.2, this function returns 1.5 on retina devices and 2 on
 non-retina ones (since a pixel is 0.5 points on retina devices and 1 otherwise).
 */
NS_INLINE CGFloat CRLRoundToNearestPixel(CGFloat length)
{
    const CGFloat screenScale = [UIScreen mainScreen].scale;

    CGFloat numerator = length * screenScale;
    numerator = (numerator < 0) ? floor(numerator) : ceil(numerator);
    return numerator / screenScale;
}

/**
 Returns the given point, having rounded its components away from zero such that they
 fall on a "pixel-integral" value (i.e., one divisible by the number of points per pixel).
 
 For example: If passed the point (0.25, -9.1), this function returns (0.5, -9.5) on
 retina devices and (1, -10) on non-retina ones (since a pixel is 0.5 points on retina
 devices and 1 otherwise).
 */
NS_INLINE CGPoint CRLRoundPointToNearestPixel(CGPoint point)
{
    return CGPointMake(CRLRoundToNearestPixel(point.x), CRLRoundToNearestPixel(point.y));
}

