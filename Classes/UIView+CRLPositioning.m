#import "UIView+CRLPositioning.h"

@implementation UIView (CRLPositioning)

-(UIView *)crl_firstSubviewOfType:(Class)aClass
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

-(CGPoint)crl_origin
{
    return self.frame.origin;
}

-(void)setCrl_origin:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = newFrame;
}

-(CGFloat)crl_x
{
    return self.frame.origin.x;
}

-(void)setCrl_x:(CGFloat)x
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = newFrame;
}

-(CGFloat)crl_y
{
    return self.frame.origin.y;
}

-(void)setCrl_y:(CGFloat)y
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = y;
    self.frame = newFrame;
}

-(CGSize)crl_size
{
    return self.frame.size;
}

-(void)setCrl_size:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
}

-(CGFloat)crl_width
{
    return self.frame.size.width;
}

-(void)setCrl_width:(CGFloat)width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

-(CGFloat)crl_height
{
    return self.frame.size.height;
}

-(void)setCrl_height:(CGFloat)height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}

@end
