//
//  NSString+CRLUtilsSpec.m
//  CRLLib
//
//  Created by Tim Clem on 3/27/14.
//  Copyright (c) 2014 Crush & Lovely. All rights reserved.
//

#import "NSData+CRLDigests.h"

SpecBegin(NSData_crl_MD5Hash)

it(@"should return the correct hash of data", ^{
    NSData *data = [@"hi" dataUsingEncoding:NSUTF8StringEncoding];
    expect([[data crl_MD5Hash] lowercaseString]).to.equal(@"49f68a5c8493ec2c0bf489821c21fc3b");
});

SpecEnd


SpecBegin(NSData_crl_SHA1Hash)

it(@"should return the correct hash of a string", ^{
    NSData *data = [@"hi" dataUsingEncoding:NSUTF8StringEncoding];
    expect([[data crl_SHA1Hash] lowercaseString]).to.equal(@"c22b5f9178342609428d6f51b2c5af4c0bde6a42");
});

SpecEnd