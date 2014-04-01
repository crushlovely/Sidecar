#import "UIView+CRLPositioning.h"

@implementation UIView (CRLPositioning)

#pragma mark - Subview utilities

-(UIView *)crl_firstSubviewOfKind:(Class)aClass
{
    for(UIView *subview in self.subviews) {
        if([subview isKindOfClass:aClass])
            return subview;
    }

    return nil;
}

-(void)crl_exchangeSubview:(UIView *)view1 withSubview:(UIView *)view2
{
    NSUInteger index1 = [self.subviews indexOfObject:view1];
    if(index1 != NSNotFound) {
        NSUInteger index2 = [self.subviews indexOfObject:view2];

        if(index2 != NSNotFound)
            [self exchangeSubviewAtIndex:(NSInteger)index1
                      withSubviewAtIndex:(NSInteger)index2];
    }
}

-(BOOL)crl_subview:(UIView *)view1 isInFrontOfSubview:(UIView *)view2
{
    NSUInteger index1 = [self.subviews indexOfObject:view1];
    if(index1 != NSNotFound) {
        NSUInteger index2 = [self.subviews indexOfObject:view2];
        if(index2 != NSNotFound)
            return index1 > index2;
    }

    return NO;
}

#pragma mark - Frame passthroughs

-(CGPoint)crl_origin
{
    return CGRectStandardize(self.frame).origin;
}

-(void)setCrl_origin:(CGPoint)origin
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin = origin;
    self.frame = newFrame;
}

-(CGFloat)crl_x
{
    return CGRectGetMinX(self.frame);
}

-(void)setCrl_x:(CGFloat)x
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.x = x;
    self.frame = newFrame;
}

-(CGFloat)crl_y
{
    return CGRectGetMinY(self.frame);
}

-(void)setCrl_y:(CGFloat)y
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.y = y;
    self.frame = newFrame;
}

-(CGSize)crl_size
{
    return CGRectStandardize(self.frame).size;
}

-(void)setCrl_size:(CGSize)size
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.size = size;
    self.frame = newFrame;
}

-(CGFloat)crl_width
{
    return CGRectGetWidth(self.frame);
}

-(void)setCrl_width:(CGFloat)width
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.size.width = width;
    self.frame = newFrame;
}

-(CGFloat)crl_height
{
    return CGRectGetHeight(self.frame);
}

-(void)setCrl_height:(CGFloat)height
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.size.height = height;
    self.frame = newFrame;
}

#pragma mark - Sides

// The top and left properties are really no different than dealing directly with origin,
// but we're using the CGRect* functions for consistency's sake.

-(CGFloat)crl_top
{
    return CGRectGetMinY(self.frame);
}

-(void)setCrl_top:(CGFloat)top
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.y = top;
    self.frame = newFrame;
}

-(CGFloat)crl_left
{
    return CGRectGetMinX(self.frame);
}

-(void)setCrl_left:(CGFloat)left
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.x = left;
    self.frame = newFrame;
}

-(CGFloat)crl_bottom
{
    return CGRectGetMaxY(self.frame);
}

-(void)setCrl_bottom:(CGFloat)bottom
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.y = bottom - newFrame.size.height;
    self.frame = newFrame;
}

-(CGFloat)crl_right
{
    return CGRectGetMaxY(self.frame);
}

-(void)setCrl_right:(CGFloat)right
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.x = right - newFrame.size.width;
    self.frame = newFrame;
}

#pragma mark - Corners

-(CGPoint)crl_topLeft
{
    return CGRectStandardize(self.frame).origin;
}

-(void)setCrl_topLeft:(CGPoint)topLeft
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin = topLeft;
    self.frame = newFrame;
}

-(CGPoint)crl_topRight
{
    CGRect f = CGRectStandardize(self.frame);
    return CGPointMake(f.origin.x, f.origin.y + f.size.width);
}

-(void)setCrl_topRight:(CGPoint)topRight
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.x = topRight.x - newFrame.size.width;
    newFrame.origin.y = topRight.y;
    self.frame = newFrame;
}

-(CGPoint)crl_bottomLeft
{
    CGRect f = CGRectStandardize(self.frame);
    return CGPointMake(f.origin.x + f.size.height, f.origin.y);
}

-(void)setCrl_bottomLeft:(CGPoint)bottomLeft
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.x = bottomLeft.x;
    newFrame.origin.y = bottomLeft.y - newFrame.size.height;
    self.frame = newFrame;
}

-(CGPoint)crl_bottomRight
{
    CGRect f = CGRectStandardize(self.frame);
    return CGPointMake(f.origin.x + f.size.height, f.origin.y + f.size.width);
}

-(void)setCrl_bottomRight:(CGPoint)bottomRight
{
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.origin.x = bottomRight.x - newFrame.size.width;
    newFrame.origin.y = bottomRight.y - newFrame.size.height;
    self.frame = newFrame;
}

@end
