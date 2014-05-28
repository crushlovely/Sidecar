// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSString+CRLUtils.h"
#import "NSData+CRLDigests.h"

@implementation NSString (CRLUtils)

-(NSString *)crl_stringByTrimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)crl_MD5Hash
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crl_MD5Hash];
}

-(NSString *)crl_SHA1Hash
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crl_SHA1Hash];
}

-(BOOL)crl_isEmptyOrWhitespace
{
    if(self.length == 0) return YES;

    NSMutableCharacterSet *notWhitespace = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [notWhitespace invert];

    return [self rangeOfCharacterFromSet:notWhitespace].location == NSNotFound;  // We didn't find none. Wot?
}

@end
