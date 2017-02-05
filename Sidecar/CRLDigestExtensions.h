// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

// Through these macros, hash properties on NSString and NSData are created called:
//  crl_{MD2,MD5,SHA1,...}Hash in Obj-C and {MD2,MD5,SHA1,...}Hash in Swift
// and HMAC methods are created called:
//  crl_{MD2,MD5,SHA1,...}HMACWithKey: in Obj-C and {MD2,MD5,SHA1,...}HMAC(key:) in Swift

#define CRLDIGESTPROPERTY(hashName) \
    @property (nonatomic, readonly) NSString *crl_ ## hashName ## Hash NS_SWIFT_NAME(hashName ## Hash)

#define CRLHMACMETHOD(hashName) \
    -(NSString *)crl_ ## hashName ## HMACWithKey:(NSData *)key NS_SWIFT_NAME(hashName ## HMAC(key:))


NS_ASSUME_NONNULL_BEGIN

@interface NSData (CRLDigests)

/**
 Returns the MD2 hash of the data, as a lowercase hexadecimal string of length 32.
 */
CRLDIGESTPROPERTY(MD2);

/**
 Returns the MD4 hash of the data, as a lowercase hexadecimal string of length 32.
 */
CRLDIGESTPROPERTY(MD4);

/**
 Returns the MD5 hash of the data, as a hexadecimal string of length 32.
 */
CRLDIGESTPROPERTY(MD5);

/**
 Returns the SHA1 hash of the data, as a lowercase hexadecimal string of length 40.
 */
CRLDIGESTPROPERTY(SHA1);

/**
 Returns the SHA224 hash of the data, as a lowercase hexadecimal string of length 56.
 */
CRLDIGESTPROPERTY(SHA224);

/**
 Returns the SHA256 hash of the data, as a lowercase hexadecimal string of length 64.
 */
CRLDIGESTPROPERTY(SHA256);

/**
 Returns the SHA384 hash of the data, as a lowercase hexadecimal string of length 96.
 */
CRLDIGESTPROPERTY(SHA384);

/**
 Returns the SHA512 hash of the data, as a lowercase hexadecimal string of length 128.
 */
CRLDIGESTPROPERTY(SHA512);

/**
 Returns the HMAC of the data using the MD5 hash and the given key, as a
 lowercase hexadecimal string of length 32.
 */
CRLHMACMETHOD(MD5);

/**
 Returns the HMAC of the data using the SHA1 hash and the given key, as a
 lowercase hexadecimal string of length 40.
 */
CRLHMACMETHOD(SHA1);

/**
 Returns the HMAC of the data using the SHA224 hash and the given key, as a
 lowercase hexadecimal string of length 56.
 */
CRLHMACMETHOD(SHA224);

/**
 Returns the HMAC of the data using the SHA256 hash and the given key, as a
 lowercase hexadecimal string of length 64.
 */
CRLHMACMETHOD(SHA256);

/**
 Returns the HMAC of the data using the SHA384 hash and the given key, as a
 lowercase hexadecimal string of length 96.
 */
CRLHMACMETHOD(SHA384);

/**
 Returns the HMAC of the data using the SHA512 hash and the given key, as a
 lowercase hexadecimal string of length 128.
 */
CRLHMACMETHOD(SHA512);

@end


@interface NSString (CRLDigests)

/**
 Returns the MD2 hash of the UTF8 encoding of the receiver, as a 32-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(MD2);

/**
 Returns the MD4 hash of the UTF8 encoding of the receiver, as a 32-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(MD4);

/**
 Returns the MD5 hash of the UTF8 encoding of the receiver, as a 32-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(MD5);

/**
 Returns the SHA1 hash of the UTF8 encoding of the receiver, as a 40-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(SHA1);

/**
 Returns the SHA224 hash of the UTF8 encoding of the receiver, as a 56-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(SHA224);

/**
 Returns the SHA256 hash of the UTF8 encoding of the receiver, as a 64-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(SHA256);

/**
 Returns the SHA384 hash of the UTF8 encoding of the receiver, as a 96-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(SHA384);

/**
 Returns the SHA512 hash of the UTF8 encoding of the receiver, as a 128-character lowercase hexadecimal string.
 */
CRLDIGESTPROPERTY(SHA512);

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the MD5 hash and the given key, as a
 lowercase hexadecimal string of length 32.
 */
CRLHMACMETHOD(MD5);

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA1 hash and the given key, as a
 lowercase hexadecimal string of length 40.
 */
CRLHMACMETHOD(SHA1);

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA224 hash and the given key, as a
 lowercase hexadecimal string of length 56.
 */
CRLHMACMETHOD(SHA224);

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA256 hash and the given key, as a
 lowercase hexadecimal string of length 64.
 */
CRLHMACMETHOD(SHA256);

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA384 hash and the given key, as a
 lowercase hexadecimal string of length 96.
 */
CRLHMACMETHOD(SHA384);

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA512 hash and the given key, as a
 lowercase hexadecimal string of length 128.
 */
CRLHMACMETHOD(SHA512);

@end


NS_ASSUME_NONNULL_END


#undef CRLDIGESTPROPERTY
#undef CRLHMACMETHOD
