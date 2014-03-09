#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Just a view with CAShapeLayer for its layerClass.
// Savin' ya some time, man.

@interface CRLShapeLayerView : UIView

@property (nonatomic, readonly) CAShapeLayer *shapeLayer;

@end