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