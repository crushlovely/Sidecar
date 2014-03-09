#import <UIKit/UIKit.h>
#import <math.h>

NS_INLINE CGFloat CRLSizeOfPixelInPoints(void)
{
    return 1.0f / [UIScreen mainScreen].scale;
}

NS_INLINE CGFloat CRLRoundToNearestPixel(CGFloat length)
{
    const CGFloat screenScale = [UIScreen mainScreen].scale;
    return roundf(length * screenScale) / screenScale;
}

NS_INLINE CGPoint CRLRoundPointToNearestPixel(CGPoint point)
{
    return CGPointMake(CRLRoundToNearestPixel(point.x), CRLRoundToNearestPixel(point.y));
}

