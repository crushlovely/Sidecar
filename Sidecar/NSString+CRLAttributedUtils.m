// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSString+CRLAttributedUtils.h"

@implementation NSString (CRLAttributedUtils)

-(NSAttributedString *)crl_attributedCopy
{
    return [[NSAttributedString alloc] initWithString:self];
}

-(NSAttributedString *)crl_attributedCopyWithAttributes:(NSDictionary<NSString *, id> *)attributes
{
    return [[NSAttributedString alloc] initWithString:self attributes:attributes];
}

-(NSMutableAttributedString *)crl_mutableAttributedCopy
{
    return [[NSMutableAttributedString alloc] initWithString:self];
}

-(NSMutableAttributedString *)crl_mutableAttributedCopyWithAttributes:(NSDictionary<NSString *, id> *)attributes
{
    return [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
}

@end
