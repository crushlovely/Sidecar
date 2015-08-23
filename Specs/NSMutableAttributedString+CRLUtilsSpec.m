// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "Specta.h"
#import "NSMutableAttributedString+CRLUtils.h"


SpecBegin(NSMutableAttributedString_CRLUtils)

describe(@"crl_appendString:", ^{
    it(@"should append the given string with no attributes", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123 }];
        [s crl_appendString:@"wow"];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"blahwow"];
        [expected addAttribute:@"attr" value:@123 range:NSMakeRange(0, 4)];

        expect(s).to.equal(expected);
    });
});

describe(@"crl_appendString:attributes:", ^{
    it(@"should append the given string with the given attributes", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah"];
        [s crl_appendString:@"wow" attributes:@{ @"attr": @123 }];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"blahwow"];
        [expected addAttribute:@"attr" value:@123 range:NSMakeRange(4, 3)];

        expect(s).to.equal(expected);
    });
});

describe(@"crl_appendFormat:", ^{
    it(@"should append the formatted string with no attributes", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123 }];
        [s crl_appendFormat:@" %.3f", M_PI];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"blah 3.142"];
        [expected addAttribute:@"attr" value:@123 range:NSMakeRange(0, 4)];

        expect(s).to.equal(expected);
    });
});

describe(@"crl_appendFormat:attributes:", ^{
    it(@"should append the formatted string with the given attributes", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah"];
        [s crl_appendFormat:@" %.3f" attributes:@{ @"attr": @123 }, M_PI];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"blah 3.142"];
        [expected addAttribute:@"attr" value:@123 range:NSMakeRange(4, 6)];

        expect(s).to.equal(expected);
    });
});

describe(@"crl_appendStringMaintainingAttributesOfFinalCharacter:", ^{
    it(@"should append the given string, extending the attributes of the final character", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123 }];
        [s crl_appendStringMaintainingAttributesOfFinalCharacter:@"wow"];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"blahwow" attributes:@{ @"attr": @123 }];

        expect(s).to.equal(expected);
    });

    it(@"should handle a zero-length receiver", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@""];
        [s crl_appendStringMaintainingAttributesOfFinalCharacter:@"wow"];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"wow"];

        expect(s).to.equal(expected);
    });
});

describe(@"crl_appendAttributedStringMergingAttributesOfFinalCharacter:", ^{
    it(@"should append the given string, adding in the attributes of the final character", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123 }];
        NSAttributedString *suffix = [[NSAttributedString alloc] initWithString:@"wow" attributes:@{ @"newattr": @456 }];
        [s crl_appendAttributedStringMergingAttributesOfFinalCharacter:suffix];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"blahwow" attributes:@{ @"attr": @123 }];
        [expected addAttribute:@"newattr" value:@456 range:NSMakeRange(4, 3)];

        expect(s).to.equal(expected);
    });

    it(@"should give precedence to the attributes of the final character in case of a collision", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123, @"newattr": @123 }];
        NSAttributedString *suffix = [[NSAttributedString alloc] initWithString:@"wow" attributes:@{ @"newattr": @456 }];
        [s crl_appendAttributedStringMergingAttributesOfFinalCharacter:suffix];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"blahwow" attributes:@{ @"attr": @123, @"newattr": @123 }];

        expect(s).to.equal(expected);
    });

    it(@"should handle a zero-length receiver", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@""];
        NSAttributedString *suffix = [[NSAttributedString alloc] initWithString:@"wow" attributes:@{ @"newattr": @456 }];
        [s crl_appendAttributedStringMergingAttributesOfFinalCharacter:suffix];

        expect(s).to.equal(suffix);
    });
});

describe(@"crl_prependStringMaintainingAttributesOfFirstCharacter:", ^{
    it(@"should prepend the given string, extending the attributes of the first character", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123 }];
        [s crl_prependStringMaintainingAttributesOfFirstCharacter:@"wow"];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"wowblah" attributes:@{ @"attr": @123 }];

        expect(s).to.equal(expected);
    });

    it(@"should handle a zero-length receiver", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@""];
        [s crl_prependStringMaintainingAttributesOfFirstCharacter:@"wow"];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"wow"];

        expect(s).to.equal(expected);
    });
});

describe(@"crl_prependAttributedStringMergingAttributesOfFirstCharacter:", ^{
    it(@"should prepend the given string, adding in the attributes of the first character", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123 }];
        NSAttributedString *prefix = [[NSAttributedString alloc] initWithString:@"wow" attributes:@{ @"newattr": @456 }];
        [s crl_prependAttributedStringMergingAttributesOfFirstCharacter:prefix];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"wowblah" attributes:@{ @"attr": @123 }];
        [expected addAttribute:@"newattr" value:@456 range:NSMakeRange(0, 3)];

        expect(s).to.equal(expected);
    });

    it(@"should give precedence to the attributes of the first character in case of a collision", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"blah" attributes:@{ @"attr": @123, @"newattr": @123 }];
        NSAttributedString *prefix = [[NSAttributedString alloc] initWithString:@"wow" attributes:@{ @"newattr": @456 }];
        [s crl_prependAttributedStringMergingAttributesOfFirstCharacter:prefix];

        NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"wowblah" attributes:@{ @"attr": @123, @"newattr": @123 }];

        expect(s).to.equal(expected);
    });

    it(@"should handle a zero-length receiver", ^{
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@""];
        NSAttributedString *prefix = [[NSAttributedString alloc] initWithString:@"wow" attributes:@{ @"newattr": @456 }];
        [s crl_prependAttributedStringMergingAttributesOfFirstCharacter:prefix];

        expect(s).to.equal(prefix);
    });
});

SpecEnd
