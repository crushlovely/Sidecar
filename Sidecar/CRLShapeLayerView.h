// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 A view with a CAShapeLayer for its layer class.
 */
@interface CRLShapeLayerView : UIView

/**
 Type-correct passthrough for the layer property.
 */
@property (nonatomic, readonly) CAShapeLayer *shapeLayer;

@end
