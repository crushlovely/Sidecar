// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <CommonCrypto/CommonCrypto.h>
#import "NSData+CRLDigests.h"

#define CRLDIGESTFUNC(hashName) \
    -(NSString *)crl_ ## hashName ## Hash { \
        const size_t hashLength = CC_ ## hashName ## _DIGEST_LENGTH; \
        unsigned char hash[hashLength]; \
        \
        CC_ ## hashName (self.bytes, (CC_LONG)self.length, hash); \
        \
        return [self crl_prettyHexStringFromBuffer:hash length:hashLength]; \
    }

#define CRLHMACFUNC(hashName) \
    -(NSString *)crl_ ## hashName ## HMACWithKey:(NSData *)key { \
        NSParameterAssert(key.length > 0); \
        \
        const size_t hmacLength = CC_ ## hashName ## _DIGEST_LENGTH; \
        unsigned char hmac[hmacLength]; \
        \
        CCHmac(kCCHmacAlg ## hashName, key.bytes, key.length, self.bytes, self.length, hmac); \
        \
        return [self crl_prettyHexStringFromBuffer:hmac length:hmacLength]; \
    }


@implementation NSData (CRLDigests)

CRLDIGESTFUNC(MD2)
CRLDIGESTFUNC(MD4)
CRLDIGESTFUNC(MD5)

CRLDIGESTFUNC(SHA1)
CRLDIGESTFUNC(SHA224)
CRLDIGESTFUNC(SHA256)
CRLDIGESTFUNC(SHA384)
CRLDIGESTFUNC(SHA512)


CRLHMACFUNC(MD5)
CRLHMACFUNC(SHA1)
CRLHMACFUNC(SHA224)
CRLHMACFUNC(SHA256)
CRLHMACFUNC(SHA384)
CRLHMACFUNC(SHA512)


-(NSString *)crl_prettyHexStringFromBuffer:(unsigned char *)buffer length:(size_t)length
{
    NSMutableString *prettified = [NSMutableString stringWithCapacity:2 * length];
    for(size_t i = 0; i < length; i++)
        [prettified appendFormat:@"%02x", buffer[i]];

    return prettified;
}

@end
