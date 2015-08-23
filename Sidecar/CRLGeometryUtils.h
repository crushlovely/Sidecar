// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <UIKit/UIKit.h>

#define CRL_PURE_INLINE NS_INLINE __pure
#define CRL_OVERLOADABLE __attribute__((overloadable))

/**
 Linearly interpolates between the given floats, returning f0 when percent is 0, and
 f1 when percent is 1.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGFloat CRLLerp(CGFloat f0, CGFloat f1, CGFloat percent)
{
    return fma(f1 - f0, percent, f0);
}

/**
 Linearly interpolates the width and height of the given sizes, returning s0 when
 percent is 0, and s1 when percent is 1.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGSize CRLLerp(CGSize s0, CGSize s1, CGFloat percent)
{
    return CGSizeMake(CRLLerp(s0.width, s1.width, percent),
                      CRLLerp(s0.height, s1.height, percent));
}

/**
 Linearly interpolates the x- and y-coordinates of the given points, returning p0 when
 percent is 0, and s1 when percent is 1.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGPoint CRLLerp(CGPoint p0, CGPoint p1, CGFloat percent)
{
    return CGPointMake(CRLLerp(p0.x, p1.x, percent),
                       CRLLerp(p0.y, p1.y, percent));
}

/**
 Linearly interpolates the origin and size of teh given CGRects, returning r0 when
 percent is 0, and r1 when percent is 1.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGRect CRLLerp(CGRect r0, CGRect r1, CGFloat percent)
{
    return (CGRect){ CRLLerp(r0.origin, r1.origin, percent),
                     CRLLerp(r0.size, r1.size, percent) };
}

/**
 Maps a value originally falling between originalMin and originalMax to a new range.
 If clamp is YES, the result is guaranteed to be >= targetMin and <= targetMax.
 */
CRL_PURE_INLINE CGFloat CRLMapRange(CGFloat value, CGFloat originalMin, CGFloat originalMax, CGFloat targetMin, CGFloat targetMax, BOOL clamp)
{
    CGFloat raw = targetMin + ((value - originalMin) / (originalMax - originalMin)) * (targetMax - targetMin);

    if(clamp) {
        if(targetMin < targetMax)
            return fmin(fmax(raw, targetMin), targetMax);
        else
            return fmin(fmax(raw, targetMax), targetMin);
    }
    return raw;
}

/**
 Returns how far between originalMin and originalMax the given value falls, as a
 percentage between 0 and 1, where 0 means value == originalMin and 1 means
 value == originalMax. If clamp is YES, the result is guaranteed to be >= 0 and <= 1.
 */
CRL_PURE_INLINE CGFloat CRLMapToPercentage(CGFloat value, CGFloat originalMin, CGFloat originalMax, BOOL clamp)
{
    return CRLMapRange(value, originalMin, originalMax, 0, 1, clamp);
}

/**
 Returns the biggest a rectangle of size contentSize can be in order to fit entirely inside
 a rectangle of containerSize, maintaining aspect ratio.
 */
CRL_PURE_INLINE CGSize CRLSizeForFittingSizeInSize(CGSize contentSize, CGSize containerSize) {
    CGFloat containerAspectRatio = fabs(containerSize.width / containerSize.height);
    CGFloat contentAspectRatio = fabs(contentSize.width / contentSize.height);

    CGSize newSize = containerSize;
    // The largest dimension will be the `maxSize`, and then we need to scale
    // the other dimension down relative to it, while maintaining the aspect
    // ratio.
    if (contentAspectRatio > containerAspectRatio) {
        newSize.height = containerSize.width / contentAspectRatio;
    } else if(contentAspectRatio < containerAspectRatio) {
        newSize.width = containerSize.height * contentAspectRatio;
    }

    return newSize;
}

/**
 Returns the smallest a rectangle of contentSize can be in order to completely fill
 a rectangle of containerSize, maintaining aspect ratio.
 */
CRL_PURE_INLINE CGSize CRLSizeForFillingSizeInSize(CGSize contentSize, CGSize containerSize)
{
    CGFloat scaleWidth = fabs(containerSize.width / contentSize.width);
    CGFloat scaleHeight = fabs(containerSize.height / contentSize.height);

    CGFloat scaleFactor = fmax(scaleWidth, scaleHeight);

    return CGSizeMake(contentSize.width * scaleFactor, contentSize.height * scaleFactor);
}

/**
 Returns the aspect ratio (width:height) of the given size.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGFloat CRLAspectRatio(CGSize size)
{
    return fabs(size.width / size.height);
}

/**
 Returns the aspect ratio (width:height) of the given rectangle.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGFloat CRLAspectRatio(CGRect rect)
{
    return CRLAspectRatio(rect.size);
}

/**
 Returns the aspect ratio (width:height) of the given image.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGFloat CRLAspectRatio(UIImage *image)
{
    return CRLAspectRatio(image.size);
}

/**
 Returns the aspect ratio (width:height) of the frame of the given view.
 */
CRL_PURE_INLINE CRL_OVERLOADABLE CGFloat CRLAspectRatio(UIView *view)
{
    return CRLAspectRatio(view.frame.size);
}
