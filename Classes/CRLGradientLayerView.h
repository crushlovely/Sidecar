#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// A view with CAGradientLayer for its layerClass and some helpers to manipulate it.
// Note that backgroundColor and gradientColors are mutually exclusive:
// Setting gradientColors results in a backgroundColor of [UIColor clearColor],
// and setting backgroundColor results in gradientColors being set to nil.

@interface CRLGradientLayerView : UIView

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

@property (nonatomic, assign) NSArray *gradientColors;  // An array of UIColor objects
@property (nonatomic, assign) NSArray *gradientLocations;  // An array of NSNumber objects; passed through to CAGradientLayer.locations

@end