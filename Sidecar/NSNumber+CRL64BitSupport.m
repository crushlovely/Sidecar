// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSNumber+CRL64BitSupport.h"

@implementation NSNumber (CRL64BitSupport)

-(CGFloat)crl_CGFloatValue
{
    #if CGFLOAT_IS_DOUBLE
        return self.doubleValue;
    #else
        return self.floatValue;
    #endif
}

@end
