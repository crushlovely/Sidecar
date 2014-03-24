#import <Foundation/Foundation.h>

@interface NSData (CRLDigests)

/**
 Returns the MD5 hash of the data, as a hexadecimal string of length 32.
 */
-(NSString *)crl_MD5Hash;

/**
 Returns the SHA1 hash of the data, as a hexadecimal string of length 40.
 */
-(NSString *)crl_SHA1Hash;

@end
