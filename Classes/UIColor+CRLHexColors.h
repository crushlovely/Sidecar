#import <UIKit/UIKit.h>

@interface UIColor (CRLHexColors)

// These take RGB hex: 0xrrggbb
+(UIColor *)crl_colorWithHex:(uint)hex alpha:(CGFloat)alpha;
+(UIColor *)crl_colorWithHex:(uint)hex;

// These take either of the following, optionally prefixed with #, 0x, or 0X:
// rrggbb (e.g. "#ffef0f")
// rgb (which does the usual CSS duplication of the values -- e.g. "#abc", which is equal to "#aabbcc")
// They return nil if the string is not of those formats.
+(UIColor *)crl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+(UIColor *)crl_colorWithHexString:(NSString *)hexString;

@end
