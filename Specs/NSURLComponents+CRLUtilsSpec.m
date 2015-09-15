//
//  NSURLComponents+CRLUtilsSpec.m
//  Sidecar
//
//  Created by Timothy Clem on 8/23/15.
//  Copyright 2015 Crush & Lovely. All rights reserved.
//

#import "Specta.h"
#import "NSURLComponents+CRLUtils.h"


SpecBegin(NSURLComponents_CRLUtils)

describe(@"crl_firstQueryItemNamed:", ^{
    __block NSURLComponents *urlComponents;

    beforeAll(^{
        NSURL *url = [NSURL URLWithString:@"http://example.com/?a=winner%20is%20you&c=d&a=123"];
        urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    });

    it(@"should return the first query item with the given name", ^{
        expect([urlComponents crl_firstQueryItemNamed:@"a"].value).to.equal(@"winner is you");
    });

    it(@"should return nil for a nonexistent query item", ^{
        expect([urlComponents crl_firstQueryItemNamed:@"nonsense"]).to.beNil();
    });
});

SpecEnd
