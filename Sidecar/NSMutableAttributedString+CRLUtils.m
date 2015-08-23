// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSMutableAttributedString+CRLUtils.h"

@implementation NSMutableAttributedString (CRLUtils)

-(void)crl_appendString:(NSString *)string
{
    if(string.length == 0) return;

    NSAttributedString *as = [[NSAttributedString alloc] initWithString:string];
    [self appendAttributedString:as];
}

-(void)crl_appendString:(NSString *)string attributes:(NSDictionary<NSString *, id> *)attributes
{
    if(string.length == 0) return;

    NSAttributedString *as = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    [self appendAttributedString:as];
}

-(void)crl_appendFormat:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);

    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:argList];

    va_end(argList);

    NSAttributedString *as = [[NSAttributedString alloc] initWithString:formattedString];
    [self appendAttributedString:as];
}

-(void)crl_appendFormat:(NSString *)format attributes:(NSDictionary<NSString *, id> *)attributes, ...
{
    va_list argList;
    va_start(argList, attributes);

    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:argList];

    va_end(argList);

    NSAttributedString *as = [[NSAttributedString alloc] initWithString:formattedString attributes:attributes];
    [self appendAttributedString:as];
}

-(void)crl_appendStringMaintainingAttributesOfFinalCharacter:(NSString *)string
{
    if(string.length == 0) return;

    if(self.length == 0) {
        [self crl_appendString:string];
        return;
    }

    NSDictionary *finalAttrs = [self attributesAtIndex:self.length - 1 effectiveRange:nil];
    [self crl_appendString:string attributes:finalAttrs];
}

-(void)crl_appendAttributedStringMergingAttributesOfFinalCharacter:(NSAttributedString *)string
{
    if(string.length == 0) return;

    if(self.length == 0) {
        [self appendAttributedString:string];
        return;
    }

    NSDictionary *finalAttrs = [self attributesAtIndex:self.length - 1 effectiveRange:nil];
    NSMutableAttributedString *mas = [string mutableCopy];
    [mas addAttributes:finalAttrs range:NSMakeRange(0, mas.length)];
    [self appendAttributedString:mas];
}

-(void)crl_prependStringMaintainingAttributesOfFirstCharacter:(NSString *)string
{
    if(string.length == 0) return;

    if(self.length == 0) {
        [self crl_appendString:string];
        return;
    }

    NSDictionary *initialAttrs = [self attributesAtIndex:0 effectiveRange:nil];
    NSAttributedString *as = [[NSAttributedString alloc] initWithString:string attributes:initialAttrs];
    [self insertAttributedString:as atIndex:0];
}

-(void)crl_prependAttributedStringMergingAttributesOfFirstCharacter:(NSAttributedString *)string
{
    if(string.length == 0) return;

    if(self.length == 0) {
        [self appendAttributedString:string];
        return;
    }

    NSDictionary *initialAttrs = [self attributesAtIndex:0 effectiveRange:nil];
    NSMutableAttributedString *mas = [string mutableCopy];
    [mas addAttributes:initialAttrs range:NSMakeRange(0, mas.length)];
    [self insertAttributedString:mas atIndex:0];
}

-(void)crl_mutateStringWithBlock:(NSString *(^)(NSString *substring))mutator
{
    NSParameterAssert(mutator);

    [self enumerateAttributesInRange:NSMakeRange(0, self.length) options:0 usingBlock:^(__unused NSDictionary *attrs, NSRange range, __unused BOOL *stop) {
        NSString *substring = mutator([self.string substringWithRange:range]);

        NSAssert(substring != nil, @"The result of the mutator block cannot be nil.");

        // replaceCharactersInRange: inherits the attributes of the first replaced character,
        // and we're enumerating such that we get called at the beginning of each attribute run,
        // so this does the right thing.
        [self replaceCharactersInRange:range withString:substring];
    }];
}

-(void)crl_uppercaseInPlaceWithLocale:(NSLocale *)locale
{
    [self crl_mutateStringWithBlock:^NSString *(NSString *substring) {
        return [substring uppercaseStringWithLocale:locale];
    }];
}

-(void)crl_lowercaseInPlaceWithLocale:(NSLocale *)locale
{
    [self crl_mutateStringWithBlock:^NSString *(NSString *substring) {
        return [substring lowercaseStringWithLocale:locale];
    }];
}

@end
