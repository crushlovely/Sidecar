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
    expect([@"  hello world" crl_stringByTrimmingWhitespace]).to.equal(@"hello world");
});

SpecEnd
