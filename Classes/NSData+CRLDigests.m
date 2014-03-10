#import <CommonCrypto/CommonDigest.h>
#import "NSData+CRLDigests.h"

@implementation NSData (CRLDigests)

-(NSString *)crl_MD5Hash
{
    unsigned char hash[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, hash);

    NSMutableString *prettified = [NSMutableString stringWithCapacity:2 * CC_MD5_DIGEST_LENGTH];
    for(size_t i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [prettified appendFormat:@"%02x", hash[i]];

    return prettified;
}

-(NSString *)crl_SHA1Hash
{
    unsigned char hash[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, hash);

    NSMutableString *prettified = [NSMutableString stringWithCapacity:2 * CC_SHA1_DIGEST_LENGTH];
    for(size_t i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [prettified appendFormat:@"%02x", hash[i]];

    return prettified;
}

@end
