// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSURLComponents+CRLUtils.h"

@implementation NSURLComponents (CRLUtils)

-(NSURLQueryItem *)crl_firstQueryItemNamed:(NSString *)name
{
    NSArray<NSURLQueryItem *> *queryItems = self.queryItems;
    for(NSURLQueryItem *queryItem in queryItems) {
        if([queryItem.name isEqualToString:name])
            return queryItem;
    }

    return nil;
}

@end
