// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CRLUtils)

/**
 Returns a new string formed by removing whitespace and newlines from both ends of the receiver.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_stringByTrimmingWhitespace;

/**
 Returns YES if the string is zero-length or consists entirely of some combination of
 whitespace and newline characters.
 */
-(BOOL)crl_isEmptyOrWhitespace;

/**
 Returns the MD2 hash of the UTF8 encoding of the receiver, as a 32-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_MD2Hash;

/**
 Returns the MD4 hash of the UTF8 encoding of the receiver, as a 32-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_MD4Hash;

/**
 Returns the MD5 hash of the UTF8 encoding of the receiver, as a 32-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_MD5Hash;

/**
 Returns the SHA1 hash of the UTF8 encoding of the receiver, as a 40-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_SHA1Hash;

/**
 Returns the SHA224 hash of the UTF8 encoding of the receiver, as a 56-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_SHA224Hash;

/**
 Returns the SHA256 hash of the UTF8 encoding of the receiver, as a 64-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_SHA256Hash;

/**
 Returns the SHA384 hash of the UTF8 encoding of the receiver, as a 96-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_SHA384Hash;

/**
 Returns the SHA512 hash of the UTF8 encoding of the receiver, as a 128-character lowercase hexadecimal string.
 */
@property (nonatomic, readonly, nonnull) NSString *crl_SHA512Hash;

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the MD5 hash and the given key, as a
 lowercase hexadecimal string of length 32.
 */
-(NSString *)crl_MD5HMACWithKey:(NSData *)key;

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA1 hash and the given key, as a
 lowercase hexadecimal string of length 40.
 */
-(NSString *)crl_SHA1HMACWithKey:(NSData *)key;

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA224 hash and the given key, as a
 lowercase hexadecimal string of length 56.
 */
-(NSString *)crl_SHA224HMACWithKey:(NSData *)key;

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA256 hash and the given key, as a
 lowercase hexadecimal string of length 64.
 */
-(NSString *)crl_SHA256HMACWithKey:(NSData *)key;

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA384 hash and the given key, as a
 lowercase hexadecimal string of length 96.
 */
-(NSString *)crl_SHA384HMACWithKey:(NSData *)key;

/**
 Returns the HMAC of the UTF8 encoding of the receiver using the SHA512 hash and the given key, as a
 lowercase hexadecimal string of length 128.
 */
-(NSString *)crl_SHA512HMACWithKey:(NSData *)key;

@end

NS_ASSUME_NONNULL_END
