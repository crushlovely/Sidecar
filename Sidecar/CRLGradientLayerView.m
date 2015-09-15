// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "CRLGradientLayerView.h"

@interface CRLGradientLayerView ()

@property (nonatomic, assign) BOOL settingBackgroundColorInternally;

@end


@implementation CRLGradientLayerView

+(Class)layerClass
{
    return [CAGradientLayer class];
}

-(CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

-(void)setGradientColors:(NSArray<UIColor *> *)gradientColors
{
    if(!gradientColors || gradientColors.count == 0)
        self.gradientLayer.colors = nil;
    else {
        NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:gradientColors.count];
        for(UIColor *color in gradientColors)
            [cgColors addObject:(id)color.CGColor];
        
        self.gradientLayer.colors = cgColors;
    }
    
    self.settingBackgroundColorInternally = YES;  // Prevents -setBackgroundColor from removing gradient colors
    self.backgroundColor = [UIColor clearColor];
}

-(NSArray<UIColor *> *)gradientColors
{
    if(!self.gradientLayer.colors)
        return nil;
    
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:self.gradientLayer.colors.count];
    for(id colorRef in self.gradientLayer.colors)
        [colors addObject:[UIColor colorWithCGColor:(CGColorRef)colorRef]];
    
    return colors;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    super.backgroundColor = backgroundColor;

    if(!self.settingBackgroundColorInternally)
        self.gradientLayer.colors = nil;  // Not -setGradientColors: to avoid a loop
    else
        self.settingBackgroundColorInternally = NO;
}

-(void)setGradientLocations:(NSArray<NSNumber *> *)gradientLocations
{
    self.gradientLayer.locations = gradientLocations;
}

-(NSArray<NSNumber *> *)gradientLocations
{
    return self.gradientLayer.locations;
}

@end
