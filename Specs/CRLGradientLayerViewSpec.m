// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "CRLGradientLayerView.h"
#import "CRLTestUtils.h"


SpecBegin(CRLGradientLayerView)

describe(@"CRLGradientLayerView", ^{
    it(@"should have a CAGradientLayer layer", ^{
        CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
        expect(view.layer).to.beKindOf([CAGradientLayer class]);
    });

    it(@"should pass through its layer via the gradientLayer property", ^{
        CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
        expect(view.gradientLayer).to.beIdenticalTo(view.layer);
    });

    it(@"should pass gradient colors to the layer and back", ^{
        CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
        view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];

        expect(((CAGradientLayer *)view.layer).colors).to.haveElementsEqualTo(@[ (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor ]);
        expect(view.gradientColors).to.haveElementsEqualTo(@[ [UIColor redColor], [UIColor blueColor] ]);
    });

    it(@"should pass gradient locations to the layer and back", ^{
        CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
        view.gradientLocations = @[ @0.0, @0.5, @1.0 ];

        expect(((CAGradientLayer *)view.layer).locations).to.haveElementsEqualTo(@[ @0.0, @0.5, @1.0 ]);
        expect(view.gradientLocations).to.haveElementsEqualTo(@[ @0.0, @0.5, @1.0 ]);
    });

    it(@"should clear backgroundColor when setting gradientColors", ^{
        CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor redColor];
        view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];

        expect(view.backgroundColor).to.equal([UIColor clearColor]);
    });

    it(@"should clear gradientColors when setting backgroundColor", ^{
        CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
        view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];
        view.backgroundColor = [UIColor redColor];

        expect(view.gradientColors).to.beNil();
    });

    it(@"should clear gradientColors when set to nil or an empty array", ^{
        CRLGradientLayerView *view = [[CRLGradientLayerView alloc] initWithFrame:CGRectZero];
        view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];

        view.gradientColors = nil;
        expect(view.gradientColors).to.beNil();

        view.gradientColors = @[ [UIColor redColor], [UIColor blueColor] ];
        view.gradientColors = @[];
        expect(view.gradientColors).to.beNil();
    });
});

SpecEnd