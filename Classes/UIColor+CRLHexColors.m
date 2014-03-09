#import "UIColor+CRLHexColors.h"

@implementation UIColor (CRLHexColors)

+(UIColor *)crl_colorWithHex:(uint)hex alpha:(CGFloat)alpha
{
    int r = (hex & 0xff0000) >> 16;
    int g = (hex & 0x00ff00) >> 8;
    int b = (hex & 0x0000ff);

    return [self colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:alpha];
}

+(UIColor *)crl_colorWithHex:(uint)hex
{
    return [self crl_colorWithHex:hex alpha:1];
}

+(UIColor *)crl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"])
        hexString = [hexString substringFromIndex:2];
    else if([hexString hasPrefix:@"#"])
        hexString = [hexString substringFromIndex:1];

    if(hexString.length == 3) {
        NSString *rc = [hexString substringWithRange:NSMakeRange(0, 1)];
        NSString *gc = [hexString substringWithRange:NSMakeRange(1, 1)];
        NSString *bc = [hexString substringWithRange:NSMakeRange(2, 1)];

        hexString = [NSString stringWithFormat:@"%@%@%@%@%@%@", rc, rc, gc, gc, bc, bc];
    }
    else if(hexString.length != 6)
        return nil;

    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    uint hex;
    if(![scanner scanHexInt:&hex])
        return nil;

    return [self crl_colorWithHex:hex alpha:alpha];
}

+(UIColor *)crl_colorWithHexString:(NSString *)hexString
{
    return [self crl_colorWithHexString:hexString alpha:1];
}

@end
