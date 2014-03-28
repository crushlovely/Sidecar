#import "CRLShapeLayerView.h"

@implementation CRLShapeLayerView

+(Class)layerClass
{
    return [CAShapeLayer class];
}

-(CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}

@end
