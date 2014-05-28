// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "UIColor+CRLHexColors.h"

@implementation UIColor (CRLHexColors)

+(UIColor *)crl_colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger r = (hex & 0xff0000) >> 16;
    NSUInteger g = (hex & 0x00ff00) >> 8;
    NSUInteger b = (hex & 0x0000ff);

    const CGFloat divisor = 255.0;

    return [self colorWithRed:r / divisor green:g / divisor blue:b / divisor alpha:alpha];
}

+(UIColor *)crl_colorWithHex:(NSUInteger)hex
{
    return [self crl_colorWithHex:hex alpha:1];
}

+(UIColor *)crl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // Valid lengths are 3 (fff), 4 (#fff), 5 (0xfff), 6 (ffffff), 7 (#ffffff), 8 (0xffffff)
    if(hexString.length < 3 || hexString.length > 8)
        return nil;

    NSUInteger valueStartIndex = 0;

    if([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"])
        valueStartIndex = 2;
    else if([hexString hasPrefix:@"#"])
        valueStartIndex = 1;

    NSRange valueRange = NSMakeRange(valueStartIndex, hexString.length - valueStartIndex);

    NSMutableCharacterSet *illegalCharacters = [NSMutableCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"];
    [illegalCharacters invert];

    if([hexString rangeOfCharacterFromSet:illegalCharacters options:0 range:valueRange].location != NSNotFound)
        return nil;

    NSInteger ir, ig, ib;
    const char *s = [hexString UTF8String] + valueRange.location;  // Skip the prefix

    if(valueRange.length == 3) {
        ir = digittoint(s[0]);
        ir |= ir << 4;

        ig = digittoint(s[1]);
        ig |= ig << 4;

        ib = digittoint(s[2]);
        ib |= ib << 4;

        CGFloat divisor = 255.0;
        return [UIColor colorWithRed:ir / divisor green:ig / divisor blue:ib / divisor alpha:alpha];
    }

    if(valueRange.length == 6) {
        NSUInteger hexVal = (NSUInteger)strtoul(s, NULL, 16);
        return [self crl_colorWithHex:hexVal alpha:alpha];
    }

    return nil;
}

+(UIColor *)crl_colorWithHexString:(NSString *)hexString
{
    return [self crl_colorWithHexString:hexString alpha:1];
}

@end
