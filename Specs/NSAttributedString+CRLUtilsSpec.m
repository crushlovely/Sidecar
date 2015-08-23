// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "Specta.h"
#import "NSAttributedString+CRLUtils.h"


SpecBegin(NSAttributedString_CRLUtils)

describe(@"crl_stringWithFormat:", ^{
    it(@"should return a formatted attributed string with no attributes", ^{
        NSAttributedString *s = [NSAttributedString crl_stringWithFormat:@"Hello %.3f!", M_PI];
        expect(s).to.equal([[NSAttributedString alloc] initWithString:@"Hello 3.142!"]);
    });
});

describe(@"crl_stringWithFormat:attributes:", ^{
    it(@"should return a formatted attributed string with the given attributes", ^{
        NSDictionary *attrs = @{ @"nonsense": @124 };
        NSAttributedString *s = [NSAttributedString crl_stringWithFormat:@"Hello %.3f!" attributes:attrs, M_PI];
        expect(s).to.equal([[NSAttributedString alloc] initWithString:@"Hello 3.142!" attributes:attrs]);
    });
});

describe(@"crl_stringByMutatingStringWithBlock:", ^{
    it(@"should handle the mutator increasing the length of the substrings", ^{
        NSDictionary *attrs = @{ @"nonsense": @123 };
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"hello" attributes:attrs];
        [s addAttribute:@"upsadaisy" value:@NO range:NSMakeRange(2, 2)];

        NSAttributedString *mutated = [s crl_stringByMutatingStringWithBlock:^NSString * _Nonnull(NSString * _Nonnull substring) {
            return [substring stringByAppendingString:@"!"];
        }];

        NSMutableAttributedString *mutableExpected = [[NSMutableAttributedString alloc] initWithString:@"he!ll!o!" attributes:attrs];
        [mutableExpected addAttribute:@"upsadaisy" value:@NO range:NSMakeRange(3, 3)];
        NSAttributedString *expected = [[NSAttributedString alloc] initWithAttributedString:mutableExpected];

        expect(mutated).to.equal(expected);
    });

    it(@"should handle the mutator decreasing the length of the substrings", ^{
        NSDictionary *attrs = @{ @"nonsense": @123 };
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"hello" attributes:attrs];
        [s addAttribute:@"upsadaisy" value:@NO range:NSMakeRange(2, 2)];

        NSAttributedString *mutated = [s crl_stringByMutatingStringWithBlock:^NSString * _Nonnull(NSString * _Nonnull substring) {
            return [substring substringToIndex:1];
        }];

        NSMutableAttributedString *mutableExpected = [[NSMutableAttributedString alloc] initWithString:@"hlo" attributes:attrs];
        [mutableExpected addAttribute:@"upsadaisy" value:@NO range:NSMakeRange(1, 1)];
        NSAttributedString *expected = [[NSAttributedString alloc] initWithAttributedString:mutableExpected];

        expect(mutated).to.equal(expected);
    });
});

describe(@"crl_uppercaseStringWithLocale:", ^{
    it(@"should return an uppercase version of the receiver with the same attributes", ^{
        NSDictionary *attrs = @{ @"nonsense": @124 };
        NSAttributedString *s = [[NSAttributedString alloc] initWithString:@"Hello 3.142!" attributes:attrs];
        s = [s crl_uppercaseStringWithLocale:nil];

        expect(s).to.equal([[NSAttributedString alloc] initWithString:@"HELLO 3.142!" attributes:attrs]);
    });

    it(@"should maintain attributes in odd capitalization situations", ^{
        NSDictionary *attrs = @{ @"nonsense": @124 };
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"Straße" attributes:attrs];
        [s addAttribute:@"eszett" value:@YES range:NSMakeRange(4, 1)];
        NSAttributedString *upcased = [s crl_uppercaseStringWithLocale:nil];

        NSMutableAttributedString *mutableExpected = [[NSMutableAttributedString alloc] initWithString:@"STRASSE" attributes:attrs];
        [mutableExpected addAttribute:@"eszett" value:@YES range:NSMakeRange(4, 2)];
        NSAttributedString *expected = [[NSAttributedString alloc] initWithAttributedString:mutableExpected];

        expect(upcased).to.equal(expected);
    });
});

describe(@"crl_lowercaseStringWithLocale:", ^{
    it(@"should return a lowercase version of the receiver with the same attributes", ^{
        NSDictionary *attrs = @{ @"nonsense": @124 };
        NSAttributedString *s = [[NSAttributedString alloc] initWithString:@"Hello 3.142!" attributes:attrs];
        s = [s crl_lowercaseStringWithLocale:nil];

        expect(s).to.equal([[NSAttributedString alloc] initWithString:@"hello 3.142!" attributes:attrs]);
    });
});

SpecEnd
