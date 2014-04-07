//
//  CRLShapeLayerViewSpec.m
//  Sidecar
//
//  Created by Tim Clem on 4/6/14.
//  Copyright (c) 2014 Crush & Lovely. All rights reserved.
//

#import "CRLShapeLayerView.h"

SpecBegin(CRLShapeLayerView)

it(@"should have a CAShapeLayer layer", ^{
    CRLShapeLayerView *view = [[CRLShapeLayerView alloc] initWithFrame:CGRectZero];
    expect(view.layer).to.beKindOf([CAShapeLayer class]);
});

it(@"should pass through its layer via the shapeLayer property", ^{
    CRLShapeLayerView *view = [[CRLShapeLayerView alloc] initWithFrame:CGRectZero];
    expect(view.shapeLayer).to.beIdenticalTo(view.layer);
});

SpecEnd
