//
//  NSString+CRLUtilsSpec.m
//  CRLLib
//
//  Created by Tim Clem on 3/27/14.
//  Copyright (c) 2014 Crush & Lovely. All rights reserved.
//

#import "NSString+CRLUtils.h"

SpecBegin(crl_stringByTrimmingWhitespace)

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

SpecEnd


SpecBegin(crl_isEmptyOrWhitespace)

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

SpecEnd


SpecBegin(crl_MD5Hash)

it(@"should return the correct hash of a string", ^{
    expect([[@"hi" crl_MD5Hash] lowercaseString]).to.equal(@"49f68a5c8493ec2c0bf489821c21fc3b");
});

it(@"should hash the UTF8 encoding of a string", ^{
    expect([[@"💩" crl_MD5Hash] lowercaseString]).to.equal(@"bd49d549f7c1f0169d6d61322a02d39d");
});

it(@"should properly hash the empty string", ^{
    expect([[@"" crl_MD5Hash] lowercaseString]).to.equal(@"d41d8cd98f00b204e9800998ecf8427e");
});

SpecEnd


SpecBegin(crl_SHA1Hash)

it(@"should return the correct hash of a string", ^{
    expect([[@"hi" crl_SHA1Hash] lowercaseString]).to.equal(@"c22b5f9178342609428d6f51b2c5af4c0bde6a42");
});

it(@"should hash the UTF8 encoding of a string", ^{
    expect([[@"💩" crl_SHA1Hash] lowercaseString]).to.equal(@"82ab1e5bf66129bdbb3d5477dfe48bfcb2545cbd");
});

it(@"should properly hash the empty string", ^{
    expect([[@"" crl_SHA1Hash] lowercaseString]).to.equal(@"da39a3ee5e6b4b0d3255bfef95601890afd80709");
});

SpecEnd