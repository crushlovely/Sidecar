// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

@interface NSString (CRLUtils)

/**
 Returns a new string formed by removing whitespace and newlines from both ends of the receiver.
 */
-(NSString *)crl_stringByTrimmingWhitespace;

/**
 Returns the MD2 hash of the UTF8 encoding of the receiver, as a 32-character hexadecimal string.
 */
-(NSString *)crl_MD2Hash;

/**
 Returns the MD4 hash of the UTF8 encoding of the receiver, as a 32-character hexadecimal string.
 */
-(NSString *)crl_MD4Hash;

/**
 Returns the MD5 hash of the UTF8 encoding of the receiver, as a 32-character hexadecimal string.
 */
-(NSString *)crl_MD5Hash;

/**
 Returns the SHA1 hash of the UTF8 encoding of the receiver, as a 40-character hexadecimal string.
 */
-(NSString *)crl_SHA1Hash;

/**
 Returns the SHA224 hash of the UTF8 encoding of the receiver, as a 56-character hexadecimal string.
 */
-(NSString *)crl_SHA224Hash;

/**
 Returns the SHA256 hash of the UTF8 encoding of the receiver, as a 64-character hexadecimal string.
 */
-(NSString *)crl_SHA256Hash;

/**
 Returns the SHA384 hash of the UTF8 encoding of the receiver, as a 96-character hexadecimal string.
 */
-(NSString *)crl_SHA384Hash;

/**
 Returns the SHA512 hash of the UTF8 encoding of the receiver, as a 128-character hexadecimal string.
 */
-(NSString *)crl_SHA512Hash;

/**
 Returns YES if the string is zero-length or consists entirely of some combination of
 whitespace and newline characters.
 */
-(BOOL)crl_isEmptyOrWhitespace;

@end
