// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "UIColor+CRLHexColors.h"

SpecBegin(UIColor_CRLHexColors)

describe(@"crl_colorWithHex", ^{
    it(@"should properly convert hex colors to a UIColor", ^{
        UIColor *color = [UIColor crl_colorWithHex:0xadbdcd];
        CGFloat r, g, b, a;
        [color getRed:&r green:&g blue:&b alpha:&a];
        r *= 255.0;
        g *= 255.0;
        b *= 255.0;

        expect(r).to.equal(0xad);
        expect(g).to.equal(0xbd);
        expect(b).to.equal(0xcd);
    });

    it(@"should default to an alpha of 1.0", ^{
        UIColor *color = [UIColor crl_colorWithHex:0x000000];
        CGFloat r, g, b, a;
        [color getRed:&r green:&g blue:&b alpha:&a];

        expect(a).to.equal(1.0);
    });

    it(@"should properly handle an alpha value if passed one", ^{
        UIColor *color = [UIColor crl_colorWithHex:0x000000 alpha:0.25];
        CGFloat r, g, b, a;
        [color getRed:&r green:&g blue:&b alpha:&a];

        expect(a).to.equal(0.25);
    });
});


describe(@"crl_colorWithHexString", ^{
    it(@"should accept a variety of prefixes", ^{
        expect([UIColor crl_colorWithHexString:@"0xffffff"]).toNot.beNil();
        expect([UIColor crl_colorWithHexString:@"0Xffffff"]).toNot.beNil();
        expect([UIColor crl_colorWithHexString:@"#ffffff"]).toNot.beNil();
        expect([UIColor crl_colorWithHexString:@"ffffff"]).toNot.beNil();
    });

    it(@"should return nil for malformed strings", ^{
        expect([UIColor crl_colorWithHexString:@"$$bobross"]).to.beNil();
        expect([UIColor crl_colorWithHexString:@"f"]).to.beNil();
        expect([UIColor crl_colorWithHexString:@"f f"]).to.beNil();
        expect([UIColor crl_colorWithHexString:@"f f f "]).to.beNil();
        expect([UIColor crl_colorWithHexString:@"0xf"]).to.beNil();
        expect([UIColor crl_colorWithHexString:@""]).to.beNil();
        expect([UIColor crl_colorWithHexString:@"0xfffffff"]).to.beNil();
        expect([UIColor crl_colorWithHexString:@"eeffgg"]).to.beNil();

        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wnonnull"
        expect([UIColor crl_colorWithHexString:nil]).to.beNil();
        #pragma clang diagnostic pop
    });

    it(@"should properly convert strings to colors", ^{
        UIColor *color = [UIColor crl_colorWithHexString:@"aabbcc"];
        CGFloat r, g, b, a;
        [color getRed:&r green:&g blue:&b alpha:&a];
        r *= 255.0;
        g *= 255.0;
        b *= 255.0;

        expect(r).to.equal(0xaa);
        expect(g).to.equal(0xbb);
        expect(b).to.equal(0xcc);
        expect(a).to.equal(1.0);

        NSArray *equivalentColors = @[
            [UIColor crl_colorWithHexString:@"abc"],
            [UIColor crl_colorWithHexString:@"#abc"],
            [UIColor crl_colorWithHexString:@"0xabc"],
            [UIColor crl_colorWithHexString:@"0XABC"],
            [UIColor crl_colorWithHexString:@"#aabbcc"],
            [UIColor crl_colorWithHexString:@"0xaabbcc"],
            [UIColor crl_colorWithHexString:@"0Xaabbcc"],
            [UIColor crl_colorWithHexString:@"0xAaBbcC"]
        ];

        for(UIColor *equivalentColor in equivalentColors)
            expect(equivalentColor).to.equal(color);
    });

    it(@"should properly handle an alpha value if passed one", ^{
        UIColor *color = [UIColor crl_colorWithHexString:@"000000" alpha:0.25];
        CGFloat r, g, b, a;
        [color getRed:&r green:&g blue:&b alpha:&a];

        expect(a).to.equal(0.25);
    });
});

SpecEnd
