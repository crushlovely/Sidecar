#import <Foundation/Foundation.h>

@interface NSData (CRLDigests)

-(NSString *)crl_MD5Hash;
-(NSString *)crl_SHA1Hash;

@end
