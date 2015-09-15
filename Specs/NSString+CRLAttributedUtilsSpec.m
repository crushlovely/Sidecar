// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "Specta.h"
#import "NSString+CRLAttributedUtils.h"


SpecBegin(NSString_CRLAttributedUtils)

describe(@"crl_attributedCopy", ^{
    it(@"should return an attributed copy of the receiver with no attributes", ^{
        NSString *s = @"hello";
        NSAttributedString *attributedCopy = [s crl_attributedCopy];
        expect(attributedCopy).to.equal([[NSAttributedString alloc] initWithString:s]);
    });
});

describe(@"crl_attributedCopyWithAttributes:", ^{
    it(@"should return an attributed copy of the receiver with the given attributes", ^{
        NSString *s = @"hello";
        NSDictionary *attrs = @{ @"nonsense": @123 };
        NSAttributedString *attributedCopy = [s crl_attributedCopyWithAttributes:attrs];
        expect(attributedCopy).to.equal([[NSAttributedString alloc] initWithString:s attributes:attrs]);
    });
});

describe(@"crl_mutableAttributedCopy", ^{
    it(@"should return a mutable attributed copy of the receiver with no attributes", ^{
        NSString *s = @"hello";
        NSMutableAttributedString *attributedCopy = [s crl_mutableAttributedCopy];
        expect(attributedCopy).to.equal([[NSMutableAttributedString alloc] initWithString:s]);
    });
});

describe(@"crl_mutableAttributedCopyWithAttributes:", ^{
    it(@"should return a mutable attributed copy of the receiver with the given attributes", ^{
        NSString *s = @"hello";
        NSDictionary *attrs = @{ @"nonsense": @123 };
        NSMutableAttributedString *attributedCopy = [s crl_mutableAttributedCopyWithAttributes:attrs];
        expect(attributedCopy).to.equal([[NSMutableAttributedString alloc] initWithString:s attributes:attrs]);
    });
});

SpecEnd
