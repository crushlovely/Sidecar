#import <Foundation/Foundation.h>

@interface NSString (CRLUtils)

-(NSString *)crl_stringByTrimmingWhitespace;
-(NSString *)crl_stringByDecodingURLFormat;

// These return the hash of the UTF8 encoding of the string
-(NSString *)crl_MD5Hash;
-(NSString *)crl_SHA1Hash;

-(BOOL)crl_isEmptyOrWhitespace;

@end
