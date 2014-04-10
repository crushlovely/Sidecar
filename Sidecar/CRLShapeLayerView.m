// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

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
