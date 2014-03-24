#import <Foundation/Foundation.h>

@interface NSString (CRLUtils)

/**
 Returns a new string formed by removing whitespace and newlines from both ends of the receiver.
 */
-(NSString *)crl_stringByTrimmingWhitespace;

/**
 Returns a new string formed by decoding percent-encoded UTF8 characters in the receiver, and
 replacing '+' with spaces.
 */
-(NSString *)crl_stringByDecodingURLFormat;

/**
 Returns the MD5 hash of the UTF8 encoding of the receiver, as a 32-character hexadecimal string.
 */
-(NSString *)crl_MD5Hash;

/**
 Returns the SHA1 hash of the UTF8 encoding of the receiver, as a 40-character hexadecimal string.
 */
-(NSString *)crl_SHA1Hash;

/**
 Returns YES if the string is zero-length or consists entirely of some combination of
 whitespace and newline characters.
 */
-(BOOL)crl_isEmptyOrWhitespace;

@end
