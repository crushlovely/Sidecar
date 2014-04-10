// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

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
