// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSMutableAttributedString+CRLUtils.h"

NSString * const CRLSoftLineBreakCharacter = @"\xE2\x80\xA8";


@implementation NSAttributedString (CRLUtils)

+(instancetype)crl_stringWithFormat:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);

    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:argList];

    va_end(argList);

    return [[self alloc] initWithString:formattedString];
}

+(instancetype)crl_stringWithFormat:(NSString *)format attributes:(NSDictionary<NSString *, id> *)attributes, ...
{
    va_list argList;
    va_start(argList, attributes);

    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:argList];

    va_end(argList);

    return [[self alloc] initWithString:formattedString attributes:attributes];
}

-(NSAttributedString *)crl_stringByMutatingStringWithBlock:(NSString *(^)(NSString *substring))mutator
{
    NSMutableAttributedString *mas = [self mutableCopy];
    [mas crl_mutateStringWithBlock:mutator];
    return mas;
}

-(NSAttributedString *)crl_uppercaseStringWithLocale:(NSLocale *)locale
{
    NSMutableAttributedString *mas = [self mutableCopy];
    [mas crl_uppercaseInPlaceWithLocale:locale];
    return mas;
}

-(NSAttributedString *)crl_lowercaseStringWithLocale:(NSLocale *)locale
{
    NSMutableAttributedString *mas = [self mutableCopy];
    [mas crl_lowercaseInPlaceWithLocale:locale];
    return mas;
}

@end
