// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <CommonCrypto/CommonDigest.h>
#import "NSData+CRLDigests.h"

#define CRLDIGESTFUNC(hashName) \
    -(NSString *)crl_ ## hashName ## Hash { \
        const size_t hashLength = CC_ ## hashName ## _DIGEST_LENGTH; \
        unsigned char hash[hashLength]; \
        CC_ ## hashName (self.bytes, (CC_LONG)self.length, hash); \
        \
        NSMutableString *prettified = [NSMutableString stringWithCapacity:2 * hashLength]; \
        for(size_t i = 0; i < hashLength; i++) \
            [prettified appendFormat:@"%02x", hash[i]]; \
        \
        return prettified; \
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

@end
