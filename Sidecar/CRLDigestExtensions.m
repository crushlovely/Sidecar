// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "CRLDigestExtensions.h"
#import <CommonCrypto/CommonCrypto.h>

#define CRLDIGESTMETHODIMPL_NSDATA(hashName) \
    -(NSString *)crl_ ## hashName ## Hash { \
        const size_t hashLength = CC_ ## hashName ## _DIGEST_LENGTH; \
        unsigned char hash[hashLength]; \
        \
        CC_ ## hashName (self.bytes, (CC_LONG)self.length, hash); \
        \
        return [self crl_prettyHexStringFromBuffer:hash length:hashLength]; \
    }

#define CRLHMACMETHODIMPL_NSDATA(hashName) \
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

#define CRLDIGESTMETHODIMPL_NSSTRING(hashName) \
    -(NSString *)crl_ ## hashName ## Hash { \
        return [[self dataUsingEncoding:NSUTF8StringEncoding] crl_ ## hashName ## Hash]; \
    }

#define CRLHMACMETHODIMPL_NSSTRING(hashName) \
    -(NSString *)crl_ ## hashName ## HMACWithKey:(NSData *)key { \
        return [[self dataUsingEncoding:NSUTF8StringEncoding] crl_ ## hashName ## HMACWithKey:key]; \
    }


@implementation NSData (CRLDigests)

CRLDIGESTMETHODIMPL_NSDATA(MD2)
CRLDIGESTMETHODIMPL_NSDATA(MD4)
CRLDIGESTMETHODIMPL_NSDATA(MD5)

CRLDIGESTMETHODIMPL_NSDATA(SHA1)
CRLDIGESTMETHODIMPL_NSDATA(SHA224)
CRLDIGESTMETHODIMPL_NSDATA(SHA256)
CRLDIGESTMETHODIMPL_NSDATA(SHA384)
CRLDIGESTMETHODIMPL_NSDATA(SHA512)


CRLHMACMETHODIMPL_NSDATA(MD5)
CRLHMACMETHODIMPL_NSDATA(SHA1)
CRLHMACMETHODIMPL_NSDATA(SHA224)
CRLHMACMETHODIMPL_NSDATA(SHA256)
CRLHMACMETHODIMPL_NSDATA(SHA384)
CRLHMACMETHODIMPL_NSDATA(SHA512)


-(NSString *)crl_prettyHexStringFromBuffer:(unsigned char *)buffer length:(size_t)length
{
    NSMutableString *prettified = [NSMutableString stringWithCapacity:2 * length];
    for(size_t i = 0; i < length; i++)
        [prettified appendFormat:@"%02x", buffer[i]];

    return prettified;
}

@end


@implementation NSString (CRLDigests)

CRLDIGESTMETHODIMPL_NSSTRING(MD2)
CRLDIGESTMETHODIMPL_NSSTRING(MD4)
CRLDIGESTMETHODIMPL_NSSTRING(MD5)

CRLDIGESTMETHODIMPL_NSSTRING(SHA1)
CRLDIGESTMETHODIMPL_NSSTRING(SHA224)
CRLDIGESTMETHODIMPL_NSSTRING(SHA256)
CRLDIGESTMETHODIMPL_NSSTRING(SHA384)
CRLDIGESTMETHODIMPL_NSSTRING(SHA512)


CRLHMACMETHODIMPL_NSSTRING(MD5)
CRLHMACMETHODIMPL_NSSTRING(SHA1)
CRLHMACMETHODIMPL_NSSTRING(SHA224)
CRLHMACMETHODIMPL_NSSTRING(SHA256)
CRLHMACMETHODIMPL_NSSTRING(SHA384)
CRLHMACMETHODIMPL_NSSTRING(SHA512)

@end
