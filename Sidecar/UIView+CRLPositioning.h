// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CRLPositioning)

/**
 Returns the first subview of the receiver that is an instance of the
 given class or a class inheriting from it.
 */
-(nullable UIView *)crl_firstSubviewOfKind:(Class)aClass;

/**
 Swaps the position of view1 and view2 in the subviews array.
 If either view is not a subview of the receiver, this method does nothing.
 */
-(void)crl_exchangeSubview:(UIView *)view1 withSubview:(UIView *)view2;

/**
 Returns YES if view1's index in the subviews array is greater than that of view2.
 Barring any external factors, this would imply that view1 would be "in front" of
 view2, if their content were to overlap.
 If either view is not a subview of the receiver, this method returns NO.
 */
-(BOOL)crl_subview:(UIView *)view1 isInFrontOfSubview:(UIView *)view2;


// All of the properties below interact with the view's frame.
// Be aware that the behavior of the frame is undefined if the view has a non-identity
// transform applied to it (in that case, rely on center and bounds).

/// The origin of the receiver's frame.
@property (nonatomic, assign) CGPoint crl_origin;
/// The x-coordinate of the receiver's frame's origin.
@property (nonatomic, assign) CGFloat crl_x;
/// The y-coordinate of the receiver's frame's origin.
@property (nonatomic, assign) CGFloat crl_y;

/// The size of the receiver's frame.
@property (nonatomic, assign) CGSize crl_size;
/// The width of the receiver's frame.
@property (nonatomic, assign) CGFloat crl_width;
/// The height of the receiver's frame.
@property (nonatomic, assign) CGFloat crl_height;

/// The minimum y-coordinate of the receiver's frame.
@property (nonatomic, assign) CGFloat crl_top;
/// The minimum x-coordinate of the receiver's frame.
@property (nonatomic, assign) CGFloat crl_left;
/// The maximum y-coordinate of the receiver's frame.
@property (nonatomic, assign) CGFloat crl_bottom;
/// The maximum x-coordinate of the receiver's frame.
@property (nonatomic, assign) CGFloat crl_right;

/// The location of the receiver's frame's top-left corner.
@property (nonatomic, assign) CGPoint crl_topLeft;
/// The location of the receiver's frame's top-right corner.
@property (nonatomic, assign) CGPoint crl_topRight;
/// The location of the receiver's frame's bottom-left corner.
@property (nonatomic, assign) CGPoint crl_bottomLeft;
/// The location of the receiver's frame's bottom-right corner.
@property (nonatomic, assign) CGPoint crl_bottomRight;

@end

NS_ASSUME_NONNULL_END
