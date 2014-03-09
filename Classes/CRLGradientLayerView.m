#import "CRLGradientLayerView.h"

@interface CRLGradientLayerView () {
    BOOL settingBackgroundColorInternally;
}

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

-(void)setGradientColors:(NSArray *)gradientColors
{
    if(!gradientColors || gradientColors.count == 0)
        self.gradientLayer.colors = nil;
    else {
        NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:gradientColors.count];
        for(UIColor *color in gradientColors)
            [cgColors addObject:(id)color.CGColor];
        
        self.gradientLayer.colors = cgColors;
    }
    
    settingBackgroundColorInternally = YES;  // Prevents -setBackgroundColor from removing gradient colors
    self.backgroundColor = [UIColor clearColor];
}

-(NSArray *)gradientColors
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
    [super setBackgroundColor:backgroundColor];

    if(!settingBackgroundColorInternally)
        self.gradientLayer.colors = nil;  // Not -setGradientColors: to avoid a loop
    else
        settingBackgroundColorInternally = NO;
}

-(void)setGradientLocations:(NSArray *)gradientLocations
{
    self.gradientLayer.locations = gradientLocations;
}

-(NSArray *)gradientLocations
{
    return self.gradientLayer.locations;
}

@end
