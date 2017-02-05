// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSString+CRLUtils.h"

SpecBegin(NSString_CRLUtils)

describe(@"string helper methods", ^{
    describe(@"crl_stringByTrimmingWhitespace", ^{
        it(@"should trim whitespace from the beginning of a string", ^{
            expect([@"  hello" crl_stringByTrimmingWhitespace]).to.equal(@"hello");
        });

        it(@"should trim whitespace from the end of a string", ^{
            expect([@"hello   " crl_stringByTrimmingWhitespace]).to.equal(@"hello");
        });

        it(@"should leave internal whitespace intact", ^{
            expect([@"  hello   world    " crl_stringByTrimmingWhitespace]).to.equal(@"hello   world");
        });

        it(@"should handle all sorts of whitespace", ^{
            // There's a bunch of nasty unicode space characters in the string below.
            expect([@"\t\nhello     \r\n" crl_stringByTrimmingWhitespace]).to.equal(@"hello");
        });

        it(@"shouldn't mangle exotic Unicode characters", ^{
            expect([@"  💩é۞  " crl_stringByTrimmingWhitespace]).to.equal(@"💩é۞");
        });
    });

    describe(@"crl_isEmptyOrWhitespace", ^{
        it(@"should return true for empty strings", ^{
            expect([@"" crl_isEmptyOrWhitespace]).to.beTruthy();
        });

        it(@"should return true for strings consisting entirely of whitespace", ^{
            expect([@"     \r\n" crl_isEmptyOrWhitespace]).to.beTruthy();
        });

        it(@"should return false for strings with non-whitespace characters", ^{
            expect([@"   a  \r\n" crl_isEmptyOrWhitespace]).to.beFalsy();
        });

        it(@"should return false for strings consisting entirely of non-whitespace characters", ^{
            expect([@"abcdefg" crl_isEmptyOrWhitespace]).to.beFalsy();
        });
    });
});

SpecEnd
