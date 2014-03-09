#import "NSString+CRLUtils.h"
#import "NSData+CRLDigests.h"

@implementation NSString (CRLUtils)

-(NSString *)crl_stringByTrimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)crl_stringByDecodingURLFormat
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
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

    NSCharacterSet *notWhitespace = [[NSCharacterSet whitespaceAndNewlineCharacterSet] invertedSet];
    return [self rangeOfCharacterFromSet:notWhitespace].location != NSNotFound;
}

@end
