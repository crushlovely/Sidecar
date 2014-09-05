// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

@interface NSData (CRLDigests)

/**
 Returns the MD2 hash of the data, as a hexadecimal string of length 32.
 */
-(NSString *)crl_MD2Hash;

/**
 Returns the MD4 hash of the data, as a hexadecimal string of length 32.
 */
-(NSString *)crl_MD4Hash;

/**
 Returns the MD5 hash of the data, as a hexadecimal string of length 32.
 */
-(NSString *)crl_MD5Hash;

/**
 Returns the SHA1 hash of the data, as a hexadecimal string of length 40.
 */
-(NSString *)crl_SHA1Hash;

/**
 Returns the SHA224 hash of the data, as a hexadecimal string of length 56.
 */
-(NSString *)crl_SHA224Hash;

/**
 Returns the SHA256 hash of the data, as a hexadecimal string of length 64.
 */
-(NSString *)crl_SHA256Hash;

/**
 Returns the SHA384 hash of the data, as a hexadecimal string of length 96.
 */
-(NSString *)crl_SHA384Hash;

/**
 Returns the SHA512 hash of the data, as a hexadecimal string of length 128.
 */
-(NSString *)crl_SHA512Hash;

@end
