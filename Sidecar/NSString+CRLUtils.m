// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSString+CRLUtils.h"
#import "NSData+CRLDigests.h"

#define CRLSTRINGHASHFUNC(hashName) \
    -(NSString *)crl_ ## hashName ## Hash { \
        return [[self dataUsingEncoding:NSUTF8StringEncoding] crl_ ## hashName ## Hash]; \
    }

@implementation NSString (CRLUtils)

-(NSString *)crl_stringByTrimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

CRLSTRINGHASHFUNC(MD2)
CRLSTRINGHASHFUNC(MD4)
CRLSTRINGHASHFUNC(MD5)

CRLSTRINGHASHFUNC(SHA1)
CRLSTRINGHASHFUNC(SHA224)
CRLSTRINGHASHFUNC(SHA256)
CRLSTRINGHASHFUNC(SHA384)
CRLSTRINGHASHFUNC(SHA512)

-(BOOL)crl_isEmptyOrWhitespace
{
    if(self.length == 0) return YES;

    NSMutableCharacterSet *notWhitespace = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [notWhitespace invert];

    return [self rangeOfCharacterFromSet:notWhitespace].location == NSNotFound;  // We didn't find none. Wot?
}

@end
