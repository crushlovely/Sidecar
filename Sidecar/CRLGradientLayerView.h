// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 CRLGradientLayerView is a UIView subclass with CAGradientLayer as its layerClass, and features several
 helpers to make it easier to manipulate the gradient.
 
 Note that the backgroundColor and gradientColors of this view are mutually exclusive: setting
 gradientColors results in a backgroundColor of [UIColor clearColor], and setting backgroundColor
 results in gradientColors being set to nil.
 */
@interface CRLGradientLayerView : UIView

/**
 A type-correct passthrough for the layer property.
 */
@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

/**
 An array of UIColor objects that specify the colors for the gradientLayer.
 @see [CAGradientLayer colors]
 */
@property (nonatomic, assign) NSArray *gradientColors;

/**
 An array of NSNumber objects that represents the locations of elements in the gradient.
 Passed through to CAGradientLayer's locations property.
 @see [CAGradientLayer locations]
 */
@property (nonatomic, assign) NSArray *gradientLocations;

@end
